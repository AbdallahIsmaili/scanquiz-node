// const express = require("express");
// const mysql = require("mysql2");
// const cors = require("cors");
// const bcrypt = require("bcryptjs");
// const jwt = require("jsonwebtoken");
// require("dotenv").config();

// const app = express();
// const port = process.env.PORT || 3001;

// app.use(cors());
// app.use(express.json());

// const db = mysql.createConnection({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASSWORD,
//   database: process.env.DB_NAME,
// });

// db.connect((err) => {
//   if (err) {
//     console.error("Error connecting to the database:", err);
//     return;
//   }
//   console.log("Connected to the MySQL database");

//   // Test query
//   db.query("SELECT 1", (err, results) => {
//     if (err) {
//       console.error("Error executing test query:", err);
//     } else {
//       console.log("Test query successful:", results);
//     }
//   });
// });

// // ROUTES:

// app.post("/register", async (req, res) => {
//   const { fullname, email, password } = req.body;

//   console.log("Received data:", req.body);

//   try {
//     const hashedPassword = await bcrypt.hash(password, 10);

//     // Check if the email already exists
//     db.query("SELECT * FROM Users WHERE email = ?", [email], (err, results) => {
//       if (err) {
//         console.error("Error checking email:", err);
//         return res.status(500).send("Error checking email");
//       }

//       if (results.length > 0) {
//         return res.status(409).send("Email already exists");
//       }

//       // If email does not exist, proceed with registration
//       db.query(
//         "INSERT INTO Users (fullname, email, password) VALUES (?, ?, ?)",
//         [fullname, email, hashedPassword],
//         (err, results) => {
//           if (err) {
//             console.error("Error registering user:", err);
//             return res.status(500).send("Error registering user");
//           }
//           res.status(201).send("User registered");
//         }
//       );
//     });
//   } catch (error) {
//     console.error("Error hashing password:", error);
//     res.status(500).send("Error hashing password");
//   }
// });



// app.post("/login", (req, res) => {
//   const { email, password } = req.body;

//   db.query(
//     "SELECT * FROM Users WHERE email = ?",
//     [email],
//     async (err, results) => {
//       if (err || results.length === 0) {
//         return res.status(401).send("User not found");
//       }

//       const user = results[0];
//       const isMatch = await bcrypt.compare(password, user.password);

//       if (!isMatch) {
//         return res.status(401).send("Incorrect password");
//       }

//       const token = jwt.sign(
//         { id: user.id, fullname: user.fullname, email: user.email },
//         process.env.JWT_SECRET,
//         {
//           expiresIn: "2h",
//         }
//       );

//       res.json({ token });
//     }
//   );
// });


// // Existing code...

// // ROUTE TO SAVE QUIZ
// app.post("/save-quiz", authenticateToken, (req, res) => {
//   const { title, questions } = req.body;
//   const userId = req.user.id;

//   db.query(
//     "INSERT INTO Quizzes (title, user_id) VALUES (?, ?)",
//     [title, userId],
//     (err, result) => {
//       if (err) {
//         console.error("Error saving quiz:", err);
//         return res.status(500).send("Error saving quiz");
//       }

//       const quizId = result.insertId;

//       questions.forEach((question, questionIndex) => {
//         db.query(
//           "INSERT INTO Questions (quiz_id, question_text, question_type, box_size) VALUES (?, ?, ?, ?)",
//           [quizId, question.text, question.type, question.boxSize || null],
//           (err, questionResult) => {
//             if (err) {
//               console.error(`Error saving question ${questionIndex + 1}:`, err);
//               return res.status(500).send(`Error saving question ${questionIndex + 1}`);
//             }

//             const questionId = questionResult.insertId;

//             question.choices.forEach((choice, choiceIndex) => {
//               db.query(
//                 "INSERT INTO Choices (question_id, choice_text, is_correct) VALUES (?, ?, ?)",
//                 [questionId, choice.text, choice.isCorrect],
//                 (err) => {
//                   if (err) {
//                     console.error(`Error saving choice ${choiceIndex + 1} for question ${questionIndex + 1}:`, err);
//                     return res.status(500).send(`Error saving choice ${choiceIndex + 1} for question ${questionIndex + 1}`);
//                   }
//                 }
//               );
//             });
//           }
//         );
//       });

//       res.status(201).send("Quiz saved successfully");
//     }
//   );
// });



// // MIDDLEWARE:
// const authenticateToken = (req, res, next) => {
//   const token = req.header("Authorization")?.split(" ")[1];

//   if (!token) return res.sendStatus(401);

//   jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
//     if (err) return res.sendStatus(403);
//     req.user = user;
//     next();
//   });
// };

// app.get("/protected", authenticateToken, (req, res) => {
//   res.send("This is a protected route");
// });

// app.get("/", (req, res) => {
//   res.send("Hello from the backend server!");
// });

// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });


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
          res.status(201).send("User registered");
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
          expiresIn: "2h",
        }
      );

      res.json({ token });
    }
  );
});

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

app.get("/protected", authenticateToken, (req, res) => {
  res.send("This is a protected route");
});

app.get("/", (req, res) => {
  res.send("Hello from the backend server!");
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
