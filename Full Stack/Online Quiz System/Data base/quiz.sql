-- ============================================
-- DATABASE
-- ============================================

CREATE DATABASE IF NOT EXISTS online_quiz;

USE online_quiz;

-- ============================================
-- USERS TABLE
-- ============================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('student','admin') DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- QUIZZES TABLE
-- ============================================

CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    duration INT NOT NULL,
    total_marks INT DEFAULT 0,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (created_by)
    REFERENCES users(id)
    ON DELETE SET NULL
);

-- ============================================
-- QUESTIONS TABLE
-- ============================================

CREATE TABLE questions (

    id INT AUTO_INCREMENT PRIMARY KEY,

    quiz_id INT NOT NULL,

    question TEXT NOT NULL,

    option1 VARCHAR(255) NOT NULL,

    option2 VARCHAR(255) NOT NULL,

    option3 VARCHAR(255) NOT NULL,

    option4 VARCHAR(255) NOT NULL,

    correct_option ENUM('1','2','3','4') NOT NULL,

    marks INT DEFAULT 1,

    FOREIGN KEY (quiz_id)
    REFERENCES quizzes(id)
    ON DELETE CASCADE
);

-- ============================================
-- STUDENT QUIZ ATTEMPTS
-- ============================================

CREATE TABLE quiz_attempts (

    id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    quiz_id INT NOT NULL,

    start_time DATETIME,

    end_time DATETIME,

    score INT DEFAULT 0,

    status ENUM('Started','Submitted') DEFAULT 'Started',

    FOREIGN KEY(user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,

    FOREIGN KEY(quiz_id)
    REFERENCES quizzes(id)
    ON DELETE CASCADE
);

-- ============================================
-- STUDENT ANSWERS
-- ============================================

CREATE TABLE answers (

    id INT AUTO_INCREMENT PRIMARY KEY,

    attempt_id INT NOT NULL,

    question_id INT NOT NULL,

    selected_option ENUM('1','2','3','4'),

    is_correct BOOLEAN,

    FOREIGN KEY(attempt_id)
    REFERENCES quiz_attempts(id)
    ON DELETE CASCADE,

    FOREIGN KEY(question_id)
    REFERENCES questions(id)
    ON DELETE CASCADE
);

-- ============================================
-- RESULTS TABLE
-- ============================================

CREATE TABLE results (

    id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    quiz_id INT NOT NULL,

    score INT,

    total_marks INT,

    percentage DECIMAL(5,2),

    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,

    FOREIGN KEY(quiz_id)
    REFERENCES quizzes(id)
    ON DELETE CASCADE
);

-- ============================================
-- ADMIN USER
-- ============================================

INSERT INTO users(name,email,password,role)

VALUES

(
'Administrator',
'admin@gmail.com',
'$2b$10$abcdefghijklmnopqrstuv123456789012345678901234567890',
'admin'
);

-- ============================================
-- SAMPLE QUIZ
-- ============================================

INSERT INTO quizzes
(title,description,duration,total_marks)

VALUES

(
'Java Basics',
'Java Programming Quiz',
20,
5
);

-- ============================================
-- SAMPLE QUESTIONS
-- ============================================

INSERT INTO questions
(quiz_id,question,option1,option2,option3,option4,correct_option,marks)

VALUES

(1,
'Who developed Java?',
'Microsoft',
'Sun Microsystems',
'Google',
'Apple',
'2',
1
),

(1,
'Java is a ____ language.',
'Programming',
'Markup',
'Scripting',
'Database',
'1',
1
),

(1,
'Which keyword is used for inheritance?',
'implements',
'extends',
'inherits',
'super',
'2',
1
),

(1,
'Which company owns Java now?',
'Google',
'Oracle',
'IBM',
'Microsoft',
'2',
1
),

(1,
'Which method is entry point of Java program?',
'start()',
'run()',
'main()',
'execute()',
'3',
1
);