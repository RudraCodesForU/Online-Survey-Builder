-- survey_table_creation- data creation (DDL)
CREATE DATABASE survey_builder;
USE survey_builder;
DROP TABLE IF EXISTS survey_answers, survey_attempts, question_bank, surveys, participants, question_conditions, survey_themes;
-- Creation of Table starting with Partiipants
CREATE TABLE participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    identity_type ENUM('registered', 'anonymous') NOT NULL,
    name VARCHAR(100),
    email VARCHAR(255),
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Creating the Surveys
CREATE TABLE surveys (
    survey_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    visibility ENUM('public', 'private') DEFAULT 'public',
    valid_from DATETIME,
    valid_until DATETIME
);
-- Creating the Question Set and requireds
CREATE TABLE question_bank (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT,
    question_text TEXT NOT NULL,
    question_type ENUM('single', 'multi', 'text', 'rating') NOT NULL,
    options_json JSON NULL,
    min_rating INT,
    max_rating INT,
    required BOOLEAN DEFAULT TRUE,
    position INT,
    page_number INT DEFAULT 1,
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);
--  Attempting Data
CREATE TABLE survey_attempts (
    attempt_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT,
    survey_id INT,
    started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    completed_at DATETIME,
    is_expired BOOLEAN DEFAULT FALSE,
    device_type VARCHAR(100),
    locale VARCHAR(10),
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id),
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);
-- Answer's Table
CREATE TABLE survey_answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    attempt_id INT,
    question_id INT,
    answer_text TEXT,
    answer_choice JSON,
    rating_value INT,
    confidence_score INT CHECK (confidence_score BETWEEN 1 AND 5),
    answered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (attempt_id) REFERENCES survey_attempts(attempt_id),
    FOREIGN KEY (question_id) REFERENCES question_bank(question_id)
);
-- Set the question conditions
CREATE TABLE question_conditions (
    condition_id INT AUTO_INCREMENT PRIMARY KEY,
    source_question_id INT NOT NULL,
    expected_value VARCHAR(255) NOT NULL,
    target_question_id INT NOT NULL,
    FOREIGN KEY (source_question_id) REFERENCES question_bank(question_id),
    FOREIGN KEY (target_question_id) REFERENCES question_bank(question_id)
);
-- Themes
CREATE TABLE survey_themes (
    theme_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT NOT NULL,
    theme_data JSON,
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);

-- Indexes for optimization
CREATE INDEX idx_answer_question ON survey_answers (question_id);
CREATE INDEX idx_attempt_survey ON survey_attempts (survey_id, participant_id);
CREATE INDEX idx_answer_attempt ON survey_answers (attempt_id);