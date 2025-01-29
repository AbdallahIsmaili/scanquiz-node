const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

db.connect((err) => {
  if (err) {
    console.error("Error connecting to the database:", err);
    return;
  }
  console.log("Connected to the MySQL database");

  // Test query
  db.query("SELECT 1", (err, results) => {
    if (err) {
      console.error("Error executing test query:", err);
    } else {
      console.log("Test query successful:", results);
    }
  });
});

// MIDDLEWARE:
const authenticateToken = (req, res, next) => {
  const authHeader = req.header("Authorization");
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    console.error("Token not found");
    return res.sendStatus(401); // Unauthorized
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      console.error("Token verification failed:", err);
      return res.sendStatus(403); // Forbidden
    }
    req.user = user;
    next();
  });
};


// ROUTES:

//auth routes
app.post("/register", async (req, res) => {
  const { fullname, email, password } = req.body;

  console.log("Received data:", req.body);

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    // Check if the email already exists
    db.query("SELECT * FROM Users WHERE email = ?", [email], (err, results) => {
      if (err) {
        console.error("Error checking email:", err);
        return res.status(500).send("Error checking email");
      }

      if (results.length > 0) {
        return res.status(409).send("Email already exists");
      }

      // If email does not exist, proceed with registration
      db.query(
        "INSERT INTO Users (fullname, email, password) VALUES (?, ?, ?)",
        [fullname, email, hashedPassword],
        (err, results) => {
          if (err) {
            console.error("Error registering user:", err);
            return res.status(500).send("Error registering user");
          }

          // Generate token and log in the user directly
          const token = jwt.sign(
            { id: results.insertId, fullname, email },
            process.env.JWT_SECRET,
            {
              expiresIn: "24h",
            }
          );

          res.json({ token });
        }
      );
    });
  } catch (error) {
    console.error("Error hashing password:", error);
    res.status(500).send("Error hashing password");
  }
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;

  db.query(
    "SELECT * FROM Users WHERE email = ?",
    [email],
    async (err, results) => {
      if (err || results.length === 0) {
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
    }
  );
});

//quiz routes
app.post("/save-quiz", authenticateToken, (req, res) => {
  const { title, questions } = req.body;
  const userId = req.user.id;

  db.query(
    "INSERT INTO Quizzes (title, user_id) VALUES (?, ?)",
    [title, userId],
    (err, result) => {
      if (err) {
        console.error("Error saving quiz:", err);
        return res.status(500).send("Error saving quiz");
      }

      const quizId = result.insertId;

      questions.forEach((question, questionIndex) => {
        db.query(
          "INSERT INTO Questions (quiz_id, question_text, question_type, box_size) VALUES (?, ?, ?, ?)",
          [quizId, question.text, question.type, question.boxSize || null],
          (err, questionResult) => {
            if (err) {
              console.error(`Error saving question ${questionIndex + 1}:`, err);
              return res.status(500).send(`Error saving question ${questionIndex + 1}`);
            }

            const questionId = questionResult.insertId;

            if (question.type === "multiple-choice" && question.choices) {
              question.choices.forEach((choice, choiceIndex) => {
                db.query(
                  "INSERT INTO Choices (question_id, choice_text, is_correct) VALUES (?, ?, ?)",
                  [questionId, choice.text, choice.isCorrect],
                  (err) => {
                    if (err) {
                      console.error(`Error saving choice ${choiceIndex + 1} for question ${questionIndex + 1}:`, err);
                      return res.status(500).send(`Error saving choice ${choiceIndex + 1} for question ${questionIndex + 1}`);
                    }
                  }
                );
              });
            }
          }
        );
      });

      res.status(201).send("Quiz saved successfully");
    }
  );
});

// Route to get quizzes
app.get("/api/quizzes", authenticateToken, (req, res) => {
  const userId = req.user.id; // assuming userId is set in authenticateToken middleware
  db.query("SELECT * FROM Quizzes WHERE user_id = ?", [userId], (err, results) => {
    if (err) {
      console.error("Error fetching quizzes:", err);
      return res.status(500).send("Error fetching quizzes");
    }
    res.json(results);
  });
});


app.delete("/api/quizzes/:quizId", authenticateToken, (req, res) => {
  const { quizId } = req.params;

  // First, delete all choices related to questions in this quiz
  db.query(
    "DELETE FROM Choices WHERE question_id IN (SELECT id FROM Questions WHERE quiz_id = ?)",
    [quizId],
    (err) => {
      if (err) {
        console.error("Error deleting choices:", err);
        return res.status(500).json({ error: "Error deleting choices" });
      }

      // Then, delete all questions related to this quiz
      db.query("DELETE FROM Questions WHERE quiz_id = ?", [quizId], (err) => {
        if (err) {
          console.error("Error deleting questions:", err);
          return res.status(500).json({ error: "Error deleting questions" });
        }

        // Finally, delete the quiz itself
        db.query("DELETE FROM Quizzes WHERE id = ?", [quizId], (err) => {
          if (err) {
            console.error("Error deleting quiz:", err);
            return res.status(500).json({ error: "Error deleting quiz" });
          }

          res.json({ message: "Quiz deleted successfully" });
        });
      });
    }
  );
});

app.put("/api/quizzes/:quizId", authenticateToken, (req, res) => {
  const { quizId } = req.params;
  const { title, newQuestion } = req.body;

  console.log(`Updating quiz ${quizId} with title '${title}'`);

  // First, update the quiz title
  db.query(
    "UPDATE Quizzes SET title = ? WHERE id = ?",
    [title, quizId],
    (err) => {
      if (err) {
        console.error("Error updating quiz title:", err);
        return res.status(500).json({ error: "Error updating quiz title" });
      }

      console.log(`Quiz title updated to '${title}'`);

      // If there's a new question, check for duplicates before adding
      if (newQuestion) {
        console.log(
          `Checking for duplicate question '${newQuestion}' in quiz ${quizId}`
        );
        db.query(
          "SELECT * FROM Questions WHERE quiz_id = ? AND question_text = ?",
          [quizId, newQuestion],
          (err, results) => {
            if (err) {
              console.error("Error checking for duplicate question:", err);
              return res
                .status(500)
                .json({ error: "Error checking for duplicate question" });
            }

            if (results.length > 0) {
              console.log(`Duplicate question found: '${newQuestion}'`);
              return res.status(400).json({
                error:
                  "A question with the same text already exists in this quiz",
              });
            }

            console.log(
              `No duplicate question found, adding new question '${newQuestion}'`
            );
            // If no duplicates, add the new question
            db.query(
              "INSERT INTO Questions (quiz_id, question_text, question_type) VALUES (?, ?, ?)",
              [quizId, newQuestion, "multiple-choice"],
              (err) => {
                if (err) {
                  console.error("Error adding new question:", err);
                  return res
                    .status(500)
                    .json({ error: "Error adding new question" });
                }

                console.log(`New question '${newQuestion}' added successfully`);
                res.json({
                  message: "Quiz updated successfully with new question",
                });
              }
            );
          }
        );
      } else {
        res.json({ message: "Quiz updated successfully" });
      }
    }
  );
});

app.get("/api/quizzes/:quizId", authenticateToken, (req, res) => {
  const { quizId } = req.params;

  db.query(
    "SELECT title FROM Quizzes WHERE id = ?",
    [quizId],
    (err, results) => {
      if (err) {
        console.error("Error fetching quiz details:", err);
        return res.status(500).json({ error: "Error fetching quiz details" });
      }

      if (results.length === 0) {
        return res.status(404).json({ error: "Quiz not found" });
      }

      res.json(results[0]);
    }
  );
});

app.get("/api/quizzes/:quizId/questions", authenticateToken, (req, res) => {
  const { quizId } = req.params;

  db.query("SELECT * FROM Questions WHERE quiz_id = ?", [quizId], (err, results) => {
    if (err) {
      console.error("Error fetching questions:", err);
      return res.status(500).send("Error fetching questions");
    }
    res.json(results);
  });
});

// questions routes
app.get("/api/questions/:questionId", authenticateToken, (req, res) => {
  const { questionId } = req.params;

  db.query(
    "SELECT * FROM Questions WHERE id = ?",
    [questionId],
    (err, questionResults) => {
      if (err) {
        console.error("Error fetching question details:", err);
        return res.status(500).send("Error fetching question details");
      }

      if (questionResults.length === 0) {
        return res.status(404).send("Question not found");
      }

      const question = questionResults[0];

      db.query(
        "SELECT * FROM Choices WHERE question_id = ?",
        [questionId],
        (err, choiceResults) => {
          if (err) {
            console.error("Error fetching choices:", err);
            return res.status(500).send("Error fetching choices");
          }

          question.choices = choiceResults;
          res.json(question);
        }
      );
    }
  );
});

app.delete("/api/questions/:questionId", authenticateToken, (req, res) => {
  const { questionId } = req.params;

  // First, delete all choices related to this question
  db.query("DELETE FROM Choices WHERE question_id = ?", [questionId], (err) => {
    if (err) {
      console.error("Error deleting choices:", err);
      return res.status(500).json({ error: "Error deleting choices" });
    }

    // Then, delete the question itself
    db.query("DELETE FROM Questions WHERE id = ?", [questionId], (err) => {
      if (err) {
        console.error("Error deleting question:", err);
        return res.status(500).json({ error: "Error deleting question" });
      }

      res.json({ message: "Question deleted successfully" });
    });
  });
});

app.put("/api/questions/:questionId", authenticateToken, (req, res) => {
  const { questionId } = req.params;
  const { question_text, question_type, box_size, choices } = req.body;

  console.log("Received data:", req.body);

  // Check for duplicate question text
  db.query(
    "SELECT * FROM Questions WHERE question_text = ? AND id != ? AND quiz_id = (SELECT quiz_id FROM Questions WHERE id = ?)",
    [question_text, questionId, questionId],
    (err, results) => {
      if (err) {
        console.error("Error checking for duplicate question text:", err);
        return res
          .status(500)
          .json({ error: "Error checking for duplicate question text" });
      }

      if (results.length > 0) {
        return res.status(400).json({ error: "Duplicate question text found" });
      }

      // Check for duplicate answers within the same question
      if (question_type === "multiple-choice" && Array.isArray(choices)) {
        const uniqueChoices = new Set(
          choices.map((choice) => choice.choice_text)
        );
        if (uniqueChoices.size !== choices.length) {
          return res
            .status(400)
            .json({
              error:
                "Duplicate answers are not allowed within the same question",
            });
        }
      }

      // Update the main question details
      db.query(
        "UPDATE Questions SET question_text = ?, question_type = ?, box_size = ? WHERE id = ?",
        [question_text, question_type, box_size || null, questionId],
        (err) => {
          if (err) {
            console.error("Error updating question details:", err);
            return res
              .status(500)
              .json({ error: "Error updating question details" });
          }

          console.log("Question details updated");

          // If the question is multiple-choice, update choices
          if (question_type === "multiple-choice" && Array.isArray(choices)) {
            db.query(
              "DELETE FROM Choices WHERE question_id = ?",
              [questionId],
              (err) => {
                if (err) {
                  console.error("Error deleting existing choices:", err);
                  return res
                    .status(500)
                    .json({ error: "Error updating choices" });
                }

                console.log("Existing choices deleted");

                const choiceInserts = choices.map((choice) => [
                  questionId,
                  choice.choice_text,
                  choice.is_correct,
                ]);

                db.query(
                  "INSERT INTO Choices (question_id, choice_text, is_correct) VALUES ?",
                  [choiceInserts],
                  (err) => {
                    if (err) {
                      console.error("Error inserting new choices:", err);
                      return res
                        .status(500)
                        .json({ error: "Error updating choices" });
                    }

                    console.log("New choices inserted");
                    res.json({
                      message: "Question and choices updated successfully",
                    });
                  }
                );
              }
            );
          } else {
            db.query(
              "DELETE FROM Choices WHERE question_id = ?",
              [questionId],
              (err) => {
                if (err) {
                  console.error(
                    "Error clearing choices for non-multiple-choice question:",
                    err
                  );
                  return res
                    .status(500)
                    .json({ error: "Error clearing choices" });
                }

                console.log("Choices cleared for non-multiple-choice question");
                res.json({ message: "Question updated successfully" });
              }
            );
          }
        }
      );
    }
  );
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
