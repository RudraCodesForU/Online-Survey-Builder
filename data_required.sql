-- data_required- sample data insertion(DML)
USE survey_builder;
-- Insert Participants
INSERT INTO participants (identity_type, name, email) VALUES
('registered', 'Rudrajyoti Chakraborty', 'rudrajyotichakraborty@domain.com'),
('anonymous', NULL, NULL),
('registered', 'Rajesh Sinha', 'rajeshsinha@domain.com'),
('registered', 'Prakhar Gupta', 'prakhargupta@domain.com');

-- Insert Survey
INSERT INTO surveys (title, description, valid_from, valid_until) VALUES
('UX Feedback', 'Survey for gathering user feedback on our new UI', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));

-- Insert themes
INSERT INTO survey_themes (survey_id, theme_data) VALUES 
(1, JSON_OBJECT(
  'primary_color', 'blue',
  'font', 'Times New Roman',
  'show_logo', true,
  'progress_bar', true,
  'welcome_text', 'We appreciate your time!'
));

-- Insert Questions
INSERT INTO question_bank (survey_id, question_text, question_type, options_json, position, page_number)
VALUES
(1, 'Which features do you use?', 'multi', JSON_ARRAY('Search', 'Profile', 'Notifications'), 1, 1),
(1, 'Rate the new design', 'rating', NULL, 2, 1),
(1, 'Any comments?', 'text', NULL, 3, 2),
(1, 'What extra feature would you like to have us?', 'text', NULL, 4, 2),
(1, 'Please share your contact details to receive a copy of your feedback', 'text', NULL, 5, 2);

-- Insert Survey Attempts
INSERT INTO survey_attempts (participant_id, survey_id, device_type, locale) VALUES
(1, 1, 'desktop', 'en-IN'),
(2, 1, 'mobile', 'en-IN'),
(3, 1, 'desktop', 'en-IN'),
(4, 1, 'mobile', 'en-IN');

-- Insert Rudrajyoti's Answers
INSERT INTO survey_answers (attempt_id, question_id, answer_choice, confidence_score)
VALUES (1, 1, JSON_ARRAY('Search', 'Profile'), 5);

INSERT INTO survey_answers (attempt_id, question_id, rating_value, confidence_score)
VALUES (1, 2, 4, 5);

INSERT INTO survey_answers (attempt_id, question_id, answer_text, confidence_score)
VALUES 
(1, 3, 'I love the new layout!', 5),
(1, 4, 'Dark mode toggle with keyboard shortcut', 5),
(1, 5, 'rudrajyotichakraborty@domain.com', 5);

-- Insert Guest's(DevifyX) Answers
INSERT INTO survey_answers (attempt_id, question_id, answer_choice, confidence_score)
VALUES (2, 1, JSON_ARRAY('Notifications'), 3);

INSERT INTO survey_answers (attempt_id, question_id, rating_value, confidence_score)
VALUES (2, 2, 5, 5);

INSERT INTO survey_answers (attempt_id, question_id, answer_text, confidence_score)
VALUES 
(2, 3, 'Dark mode please.', 4),
(2, 4, 'Offline feedback form option', 4),
(2, 5, 'guest@DevifyX.org', 3);

-- Insert Rajesh's Answers
INSERT INTO survey_answers (attempt_id, question_id, answer_choice, confidence_score)
VALUES (3, 1, JSON_ARRAY('Search', 'Profile'), 4);

INSERT INTO survey_answers (attempt_id, question_id, rating_value, confidence_score)
VALUES (3, 2, 4, 5);

INSERT INTO survey_answers (attempt_id, question_id, answer_text, confidence_score)
VALUES 
(3, 3, 'UI is intuitive and fast.', 4),
(3, 4, 'Voice feedback feature would help.', 4),
(3, 5, 'rajeshsinha@domain.com', 4);

-- Insert Prakhar's Answers
INSERT INTO survey_answers (attempt_id, question_id, answer_choice, confidence_score)
VALUES (4, 1, JSON_ARRAY('Search', 'Profile'), 3);

INSERT INTO survey_answers (attempt_id, question_id, rating_value, confidence_score)
VALUES (4, 2, 3, 3);

INSERT INTO survey_answers (attempt_id, question_id, answer_text, confidence_score)
VALUES 
(4, 3, 'Too cluttered on small screens.', 3),
(4, 4, 'Add support for screen readers.', 3),
(4, 5, 'prakhargupta@domain.com', 3);