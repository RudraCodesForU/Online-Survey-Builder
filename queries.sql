-- queries.sql- Required query checks for survey builds

-- 1. Total participants per survey
SELECT s.title, COUNT(DISTINCT a.participant_id) AS participants
FROM survey_attempts a
JOIN surveys s ON a.survey_id = s.survey_id
GROUP BY a.survey_id;

-- 2. Average rating per question
SELECT qb.question_text, AVG(sa.rating_value) AS avg_rating
FROM survey_answers sa
JOIN question_bank qb ON sa.question_id = qb.question_id
WHERE qb.question_type = 'rating'
GROUP BY sa.question_id;

-- 3. Multi-choice answer breakdown using JSON_TABLE
SELECT qb.question_text, jt.option_value, COUNT(*) AS selected_count
FROM survey_answers sa
JOIN question_bank qb ON sa.question_id = qb.question_id
JOIN JSON_TABLE(sa.answer_choice, '$[*]' COLUMNS(option_value VARCHAR(100) PATH '$')) AS jt
WHERE qb.question_type = 'multi'
GROUP BY sa.question_id, jt.option_value;

-- 4. Text responses
SELECT qb.question_text, sa.answer_text
FROM survey_answers sa
JOIN question_bank qb ON sa.question_id = qb.question_id
WHERE qb.question_type = 'text';

-- 5. Anonymous responses count
SELECT COUNT(*) AS anonymous_responses
FROM survey_attempts sa
JOIN participants p ON sa.participant_id = p.participant_id
WHERE p.identity_type = 'anonymous';

-- 6. Fetch questions for a specific page
SELECT *
FROM question_bank
WHERE survey_id = 1 AND page_number = 2
ORDER BY position;

-- 7. CSV export 
SELECT
  IFNULL(MAX(p.name), 'Anonymous') AS `Participant Name`,
  sa.attempt_id AS `Attempt ID`,
  GROUP_CONCAT(jt.option_value) AS `Which features do you use?`,
  MAX(sa2.rating_value) AS `Rate the new design`,
  MAX(sa3.answer_text) AS `Any comments?`,
  MAX(sa4.answer_text) AS `What extra feature would you like to have us?`,
  MAX(sa5.answer_text) AS `Contact Info`

INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/survey_export.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'

FROM survey_answers sa
JOIN survey_attempts a ON sa.attempt_id = a.attempt_id
JOIN participants p ON a.participant_id = p.participant_id
JOIN survey_answers sa1 ON sa.attempt_id = sa1.attempt_id AND sa1.question_id = 1
JOIN JSON_TABLE(
    sa1.answer_choice,
    '$[*]' COLUMNS(option_value VARCHAR(100) PATH '$')
) AS jt ON TRUE

JOIN survey_answers sa2 ON sa.attempt_id = sa2.attempt_id AND sa2.question_id = 2
JOIN survey_answers sa3 ON sa.attempt_id = sa3.attempt_id AND sa3.question_id = 3
JOIN survey_answers sa4 ON sa.attempt_id = sa4.attempt_id AND sa4.question_id = 4
JOIN survey_answers sa5 ON sa.attempt_id = sa5.attempt_id AND sa5.question_id = 5

WHERE sa.question_id = 1
GROUP BY sa.attempt_id
ORDER BY sa.attempt_id;