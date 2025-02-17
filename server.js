const express = require("express");
const mysql = require("mysql2/promise"); // Use the promise-based API
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();
const multer = require("multer");
const fs = require("fs");
const pdfParse = require("pdf-parse");
const Tesseract = require("tesseract.js");
const path = require("path");
const { exec } = require("child_process");
const sharp = require("sharp");

const app = express();
const port = process.env.PORT || 3001;
const upload = multer({ dest: "uploads/" });


app.use(cors());
app.use(express.json());

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// MIDDLEWARE:
const authenticateToken = (req, res, next) => {
  const authHeader = req.header("Authorization");
  console.log("Authorization Header:", authHeader); 

  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    console.error("Token not found");
    return res.sendStatus(401); 
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      console.error("Token verification failed:", err);
      return res.sendStatus(403); 
    }
    req.user = user;
    next();
  });
};




//auth routes
app.post("/register", async (req, res) => {
  const { fullname, email, password } = req.body;

  console.log("Received data:", req.body);

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const [results] = await db.query("SELECT * FROM Users WHERE email = ?", [
      email,
    ]);

    if (results.length > 0) {
      return res.status(409).send("Email already exists");
    }

    const [insertResults] = await db.query(
      "INSERT INTO Users (fullname, email, password) VALUES (?, ?, ?)",
      [fullname, email, hashedPassword]
    );

    const token = jwt.sign(
      { id: insertResults.insertId, fullname, email },
      process.env.JWT_SECRET,
      {
        expiresIn: "24h",
      }
    );

    res.json({ token });
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).send("Error registering user");
  }
});

app.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const [results] = await db.query("SELECT * FROM Users WHERE email = ?", [
      email,
    ]);

    if (results.length === 0) {
      return res.status(401).send("User not found");
    }

    const user = results[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).send("Incorrect password");
    }

    const token = jwt.sign(
      { id: user.id, fullname: user.fullname, email: user.email },
      process.env.JWT_SECRET,
      {
        expiresIn: "24h",
      }
    );

    res.json({ token });
  } catch (error) {
    console.error("Error logging in user:", error);
    res.status(500).send("Error logging in user");
  }
});


//quiz routes
app.post("/save-quiz", authenticateToken, async (req, res) => {
  const { title, questions, exam_id } = req.body;
  const userId = req.user.id;

  console.log("Received exam_id:", exam_id);

  if (!exam_id) {
    console.error("❌ Exam ID is missing!");
    return res.status(400).send("Exam ID is required");
  }

  try {
    const [quizResults] = await db.query(
      "SELECT id FROM Quizzes WHERE title = ? AND user_id = ?",
      [title, userId]
    );

    if (quizResults.length > 0) {
      await db.query(
        "UPDATE Quizzes SET exam_id = ? WHERE title = ? AND user_id = ?",
        [exam_id, title, userId]
      );
      console.log("✅ Updated exam_id:", exam_id);
    } else {
      const [insertResults] = await db.query(
        "INSERT INTO Quizzes (title, user_id, exam_id) VALUES (?, ?, ?)",
        [title, userId, exam_id]
      );
      console.log("✅ New quiz inserted with exam_id:", exam_id);
    }

    const [updatedQuizResults] = await db.query(
      "SELECT id FROM Quizzes WHERE title = ? AND user_id = ?",
      [title, userId]
    );
    const quizId = updatedQuizResults[0].id;

    for (const question of questions) {
      const { question_text, question_type, box_size } = question;
      const [questionResults] = await db.query(
        "INSERT INTO Questions (quiz_id, question_text, question_type, box_size) VALUES (?, ?, ?, ?)",
        [quizId, question_text, question_type, box_size]
      );
      
      const questionId = questionResults.insertId;
      for (const choice of question.choices) {
        const { choice_text, is_correct } = choice;
        await db.query(
          "INSERT INTO Choices (question_id, choice_text, is_correct) VALUES (?, ?, ?)",
          [questionId, choice_text, is_correct]
        );
      }
    }

    res.status(201).json({ message: "Quiz saved successfully", exam_id });
  } catch (error) {
    console.error("❌ Error saving quiz:", error);
    res.status(500).send("Error saving quiz");
  }
});


// Route to get quizzes
app.get("/api/quizzes", authenticateToken, async (req, res) => {
  const userId = req.user.id; 
  console.log("User ID:", userId);

  try {
    const [results] = await db.query(
      "SELECT * FROM Quizzes WHERE user_id = ?",
      [userId]
    );

    console.log("Quizzes fetched:", results); 
    res.json(results); 
  } catch (err) {
    console.error("Error fetching quizzes:", err);
    res.status(500).send("Error fetching quizzes");
  }
});


app.delete("/api/quizzes/:quizId", authenticateToken, async (req, res) => {
  const { quizId } = req.params;

  try {
    await db.query(
      "DELETE FROM Choices WHERE question_id IN (SELECT id FROM Questions WHERE quiz_id = ?)",
      [quizId]
    );

    await db.query("DELETE FROM Questions WHERE quiz_id = ?", [quizId]);

    await db.query("DELETE FROM Quizzes WHERE id = ?", [quizId]);

    res.json({ message: "Quiz deleted successfully" });
  } catch (err) {
    console.error("Error deleting quiz:", err);
    res.status(500).json({ error: "Error deleting quiz" });
  }
});

app.put("/api/quizzes/:quizId", authenticateToken, async (req, res) => {
  const { quizId } = req.params;
  const { title, newQuestion } = req.body;

  console.log(`Updating quiz ${quizId} with title '${title}'`);

  try {
    await db.query("UPDATE Quizzes SET title = ? WHERE id = ?", [
      title,
      quizId,
    ]);
    console.log(`Quiz title updated to '${title}'`);

    if (newQuestion) {
      console.log(
        `Checking for duplicate question '${newQuestion}' in quiz ${quizId}`
      );

      const [results] = await db.query(
        "SELECT * FROM Questions WHERE quiz_id = ? AND question_text = ?",
        [quizId, newQuestion]
      );

      if (results.length > 0) {
        console.log(`Duplicate question found: '${newQuestion}'`);
        return res.status(400).json({
          error: "A question with the same text already exists in this quiz",
        });
      }

      console.log(
        `No duplicate question found, adding new question '${newQuestion}'`
      );

      await db.query(
        "INSERT INTO Questions (quiz_id, question_text, question_type) VALUES (?, ?, ?)",
        [quizId, newQuestion, "multiple-choice"]
      );

      console.log(`New question '${newQuestion}' added successfully`);
      res.json({
        message: "Quiz updated successfully with new question",
      });
    } else {
      res.json({ message: "Quiz updated successfully" });
    }
  } catch (err) {
    console.error("Error updating quiz:", err);
    res.status(500).json({ error: "Error updating quiz" });
  }
});

app.get("/api/quizzes/:quizId", authenticateToken, async (req, res) => {
  const { quizId } = req.params;

  try {
    const [results] = await db.query("SELECT title FROM Quizzes WHERE id = ?", [
      quizId,
    ]);

    if (results.length === 0) {
      return res.status(404).json({ error: "Quiz not found" });
    }

    res.json(results[0]);
  } catch (err) {
    console.error("Error fetching quiz details:", err);
    res.status(500).json({ error: "Error fetching quiz details" });
  }
});

app.get("/api/quizzes/:quizId/questions", authenticateToken, async (req, res) => {
    const { quizId } = req.params;
    console.log("Fetching questions for quiz ID:", quizId);

    try {
      const query = `
      SELECT q.id AS question_id, q.question_text, q.question_type, q.box_size,
             c.id AS choice_id, c.choice_text, c.is_correct
      FROM Questions q
      LEFT JOIN Choices c ON q.id = c.question_id
      WHERE q.quiz_id = ?`;

      const [results] = await db.query(query, [quizId]);
      console.log("Query results:", results);

      if (results.length === 0) {
        return res.json([]); 
      }

      const questionsMap = new Map();

      results.forEach((row) => {
        if (!questionsMap.has(row.question_id)) {
          questionsMap.set(row.question_id, {
            id: row.question_id,
            question_text: row.question_text,
            question_type: row.question_type,
            box_size: row.box_size,
            choices: [],
          });
        }

        if (row.choice_id) {
          questionsMap.get(row.question_id).choices.push({
            id: row.choice_id,
            choice_text: row.choice_text,
            is_correct: row.is_correct,
          });
        }
      });

      const formattedQuestions = [...questionsMap.values()];
      console.log("Formatted questions:", formattedQuestions);
      res.json(formattedQuestions);
    } catch (err) {
      console.error("Error fetching questions:", err);
      res.status(500).send("Error fetching questions");
    }
  }
);



app.get("/api/questions/:questionId", authenticateToken, async (req, res) => {
  const { questionId } = req.params;

  try {
    const [questionResults] = await db.query(
      "SELECT * FROM Questions WHERE id = ?",
      [questionId]
    );

    if (questionResults.length === 0) {
      return res.status(404).send("Question not found");
    }

    const question = questionResults[0];

    const [choiceResults] = await db.query(
      "SELECT * FROM Choices WHERE question_id = ?",
      [questionId]
    );

    question.choices = choiceResults;
    res.json(question);
  } catch (err) {
    console.error("Error fetching question details:", err);
    res.status(500).send("Error fetching question details");
  }
});

app.delete( "/api/questions/:questionId", authenticateToken, async (req, res) => {
    const { questionId } = req.params;

    try {
      await db.query("DELETE FROM Choices WHERE question_id = ?", [questionId]);

      await db.query("DELETE FROM Questions WHERE id = ?", [questionId]);

      res.json({ message: "Question deleted successfully" });
    } catch (err) {
      console.error("Error deleting question:", err);
      res.status(500).json({ error: "Error deleting question" });
    }
  }
);

app.put("/api/questions/:questionId", authenticateToken, async (req, res) => {
  const { questionId } = req.params;
  const { question_text, question_type, box_size, choices } = req.body;

  console.log("Received data:", req.body);

  try {
    const [duplicateResults] = await db.query(
      "SELECT * FROM Questions WHERE question_text = ? AND id != ? AND quiz_id = (SELECT quiz_id FROM Questions WHERE id = ?)",
      [question_text, questionId, questionId]
    );

    if (duplicateResults.length > 0) {
      return res.status(400).json({ error: "Duplicate question text found" });
    }

    if (question_type === "multiple-choice" && Array.isArray(choices)) {
      const uniqueChoices = new Set(
        choices.map((choice) => choice.choice_text)
      );
      if (uniqueChoices.size !== choices.length) {
        return res.status(400).json({
          error: "Duplicate answers are not allowed within the same question",
        });
      }
    }

    // Update the main question details
    await db.query(
      "UPDATE Questions SET question_text = ?, question_type = ?, box_size = ? WHERE id = ?",
      [question_text, question_type, box_size || null, questionId]
    );

    console.log("Question details updated");

    // If the question is multiple-choice, update choices
    if (question_type === "multiple-choice" && Array.isArray(choices)) {
      await db.query("DELETE FROM Choices WHERE question_id = ?", [questionId]);
      console.log("Existing choices deleted");

      const choiceInserts = choices.map((choice) => [
        questionId,
        choice.choice_text,
        choice.is_correct,
      ]);

      await db.query(
        "INSERT INTO Choices (question_id, choice_text, is_correct) VALUES ?",
        [choiceInserts]
      );

      console.log("New choices inserted");
      res.json({
        message: "Question and choices updated successfully",
      });
    } else {
      await db.query("DELETE FROM Choices WHERE question_id = ?", [questionId]);
      console.log("Choices cleared for non-multiple-choice question");
      res.json({ message: "Question updated successfully" });
    }
  } catch (err) {
    console.error("Error updating question:", err);
    res.status(500).json({ error: "Error updating question" });
  }
});

// CORRECTION

app.post("/upload", upload.array("files"), async (req, res) => {
  try {
    const extractedData = [];

    for (const file of req.files) {
      const filePath = file.path;
      const fileExt = file.mimetype.split("/")[1];

      let text = "";
      if (fileExt === "pdf") {
        text = await extractTextFromPDF(filePath);
      } else if (["jpeg", "jpg", "png"].includes(fileExt)) {
        text = await extractTextFromImage(filePath);
      }

      console.log("Extracted Raw Text:", text);
      console.log("Parsed Answers:", extractAnswers(text));

      const studentInfo = extractStudentInfo(text);
      const answers = extractAnswers(text);
      extractedData.push({ studentInfo, answers, text });
    }

    res.json({ extractedData });
  } catch (error) {
    console.error("❌ ERROR:", error); // Log the error
    res.status(500).json({ error: error.message || "Error processing files" });
  }
});

const convertPdfToImage = async (filePath) => {
  return new Promise((resolve, reject) => {
    const outputPrefix = filePath.replace(".pdf", "");
    exec(
      `pdftoppm -png "${filePath}" "${outputPrefix}"`,
      (error, stdout, stderr) => {
        if (error) {
          console.error("❌ PDF Conversion Error:", stderr);
          return reject(new Error("Failed to convert PDF to images."));
        }

        const imageFiles = fs
          .readdirSync(path.dirname(filePath))
          .filter(
            (file) =>
              file.startsWith(path.basename(filePath, ".pdf")) &&
              file.endsWith(".png")
          )
          .map((file) => path.join(path.dirname(filePath), file));

        if (imageFiles.length === 0) {
          return reject(new Error("No images were generated from the PDF."));
        }

        resolve(imageFiles);
      }
    );
  });
};

const extractTextFromPDF = async (filePath) => {
  const dataBuffer = fs.readFileSync(filePath);
  const data = await pdfParse(dataBuffer);

  // If the extracted text is empty or missing answers, use OCR
  if (data.text.trim().length < 50 || !data.text.includes("Q1")) {
    console.log("Switching to OCR for better extraction...");
    return await extractTextFromImage(filePath); // Use OCR as fallback
  }

  return data.text;
};

const extractTextFromImage = async (filePath) => {
  const processedImagePath = `${filePath}-processed.png`;

  // Preprocess image: Convert to grayscale, increase contrast, and remove noise
  await sharp(filePath)
    .grayscale() // Convert to black & white
    .threshold(180) // Remove background noise
    .toFile(processedImagePath);

  return Tesseract.recognize(processedImagePath, "eng", {
    logger: (m) => console.log(m),
    tessedit_char_whitelist:
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ",
  }).then(({ data: { text } }) => {
    console.log("Extracted Raw Text from Image:", text);
    return text;
  });
};

const extractStudentInfo = (text) => {
  // Extract full name (stop capturing at "class" keyword)
  const fullNameMatch = text.match(
    /Fullname:\s*_\s*\|?\s*([A-Z\s]+?)\s*(?=class:)/i
  );
  const classMatch = text.match(/class:\s*_([a-z0-9]+)\s*_/i);
  const cinMatch = text.match(/emn:\.\s*([A-Z0-9]+)/i);

  return {
    fullName: fullNameMatch ? fullNameMatch[1].trim().replace(/\s+/g, " ") : "",
    class: classMatch ? classMatch[1].trim() : "",
    cin: cinMatch ? cinMatch[1].trim() : "",
  };
};

const extractAnswers = (text) => {
  const lines = text
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line);

  const answers = [];
  const answerOptions = ["A", "B", "C", "D"];

  lines.forEach((line) => {
    // Match a row like "Q1   x       x"
    const match = line.match(/^Q?(\d+)\s+([X\s]*)$/i);
    if (match) {
      const questionNumber = match[1];
      const answerMarks = match[2].split(/\s+/); // Split by spaces

      let selectedAnswers = [];
      answerMarks.forEach((mark, index) => {
        if (mark.toLowerCase() === "x" || mark === "X") {
          selectedAnswers.push(answerOptions[index]);
        }
      });

      answers.push({
        question: questionNumber,
        answer: selectedAnswers.join(", "),
      });
    }
  });

  return answers;
};


app.get("/api/exam-info/:exam_id", async (req, res) => {
  const examId = req.params.exam_id;

  try {
    const [examDetails] = await db.query(
      "SELECT * FROM quizzes WHERE exam_id = ?",
      [examId]
    );
    console.log("Exam Details: ", examDetails);

    if (examDetails.length === 0) {
      return res.status(404).json({ message: "Exam not found" });
    }

    const [questions] = await db.query(
      "SELECT * FROM questions WHERE quiz_id = ?",
      [examDetails[0].id]
    );
    console.log("Questions: ", questions);

    let choices = [];
    if (questions.length > 0) {
      const questionIds = questions.map((q) => q.id);
      [choices] = await db.query(
        "SELECT * FROM choices WHERE question_id IN (?)",
        [questionIds]
      );
      console.log("Choices: ", choices);
    }

    const examData = {
      exam_info: examDetails[0],
      questions: questions.map((question) => ({
        ...question,
        choices: choices.filter((choice) => choice.question_id === question.id),
      })),
    };

    res.json(examData);
  } catch (error) {
    console.error("Error fetching exam data:", error);
    res.status(500).json({ message: "Failed to fetch exam data" });
  }
});


app.get("/api/exam/:examId", async (req, res) => {
  const { examId } = req.params;
  const { maxScore } = req.query; 

  try {
    const [examInfo] = await db.query(
      `SELECT title FROM quizzes WHERE exam_id = ?`,
      [examId]
    );

    if (!examInfo.length) {
      return res.status(404).json({ message: "Exam not found" });
    }

    const [questions] = await db.query(
      `SELECT id, question_text FROM questions WHERE quiz_id = ?`,
      [examId]
    );

    const [studentResults] = await db.query(
      `SELECT id, name, cin, class, score FROM studentresults WHERE exam_id = ?`,
      [examId]
    );

    const [studentAnswers] = await db.query(
      `SELECT student_id, question, chosen_options, is_correct, correct_answers 
       FROM studentanswers 
       WHERE exam_id = ?`,
      [examId]
    );

    const students = studentResults.map((student) => {
      const answers = studentAnswers
        .filter((answer) => answer.student_id === student.id)
        .map((answer) => ({
          question: answer.question,
          selectedChoices: answer.chosen_options.split(", "),
          isCorrect: answer.is_correct === 1,
          correctAnswers: answer.correct_answers.split(", "),
        }));

      return {
        student_info: {
          Name: student.name,
          CIN: student.cin,
          Class: student.class,
        },
        score: student.score,
        answers: answers,
      };
    });

    res.json({
      exam_info: {
        title: examInfo[0].title,
        exam_id: examId,
        max_score: maxScore || 20, 
      },
      questions: questions, 
      students: students,
    });
  } catch (error) {
    console.error("Error fetching exam data:", error);
    res.status(500).json({ message: "Failed to fetch exam data" });
  }
});


app.post("/api/save-results", async (req, res) => {
  const { examId, students } = req.body;

  if (!examId || !students.length) {
    return res.status(400).json({ message: "Invalid data provided" });
  }

  try {
    const studentValues = students.map((student) => [
      student.student_info?.Name || "Unknown",
      student.student_info?.CIN || "N/A",
      student.student_info?.Class || "N/A",
      examId,
      student.score,
    ]);

    const studentSql = `
      INSERT INTO StudentResults (name, cin, class, exam_id, score) 
      VALUES ?
      ON DUPLICATE KEY UPDATE score = VALUES(score)
    `;
    await db.query(studentSql, [studentValues]);

    const [studentIds] = await db.query(
      `SELECT id, name, cin, class 
       FROM StudentResults 
       WHERE exam_id = ?`,
      [examId]
    );

    const studentIdMap = new Map();
    studentIds.forEach((student) => {
      const key = `${student.name}-${student.cin}-${student.class}`;
      studentIdMap.set(key, student.id);
    });

    const answerValues = [];
    students.forEach((student) => {
      const key = `${student.student_info?.Name || "Unknown"}-${
        student.student_info?.CIN || "N/A"
      }-${student.student_info?.Class || "N/A"}`;
      const studentId = studentIdMap.get(key);

      if (studentId) {
        student.answers.forEach((answer) => {
          answerValues.push([
            studentId, 
            examId,
            answer.question,
            answer.selectedChoices.join(", "), 
            answer.isCorrect ? 1 : 0, 
            answer.correctAnswers.join(", "), 
          ]);
        });
      }
    });

    if (answerValues.length > 0) {
      const answerSql = `
        INSERT INTO StudentAnswers (student_id, exam_id, question, chosen_options, is_correct, correct_answers) 
        VALUES ?
        ON DUPLICATE KEY UPDATE 
          chosen_options = VALUES(chosen_options),
          is_correct = VALUES(is_correct),
          correct_answers = VALUES(correct_answers)
      `;
      await db.query(answerSql, [answerValues]);
    }

    res.json({
      message: "Results and answers saved or updated successfully",
    });
  } catch (error) {
    console.error("Error saving results:", error);
    res.status(500).json({ message: "Failed to save results" });
  }
});


app.get("/api/most-difficult-questions/:examId", async (req, res) => {
  const { examId } = req.params;

  try {
    const [results] = await db.query(
      `
      SELECT sa.question, COUNT(*) AS incorrect_count
      FROM StudentAnswers sa
      JOIN StudentResults sr ON sa.student_id = sr.id
      WHERE sa.exam_id = ? AND sa.is_correct = 0
      GROUP BY sa.question
      ORDER BY incorrect_count DESC
      LIMIT 5;
      `,
      [examId]
    );

    res.json(results);
  } catch (error) {
    console.error("Error fetching most difficult questions:", error);
    res.status(500).json({ message: "Failed to fetch difficult questions" });
  }
});


app.get("/protected", authenticateToken, (req, res) => {
  res.send("This is a protected route");
});

app.get("/", (req, res) => {
  res.send("Hello from the backend server!");
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
