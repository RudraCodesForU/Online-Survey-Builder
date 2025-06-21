-- README.sql
-- ============================================
-- Online Survey Builder – SQL-Only Assignment
-- Organisation - DevifyX
-- Coder: Rudrajyoti Chakraborty
-- Date: 21th June 2025
-- ============================================

-- Overview:
-- This project implements a complete survey system using SQL only.
-- It supports creating surveys, adding questions of multiple types,
-- collecting answers, and generating analytical reports.

-- Features Implemented:
-- [x] Survey creation (title, description, time window)
-- [x] Multiple question types: single, multi, text, ratings
-- [x] Anonymous participation
-- [x] Conditional question branching
-- [x] Result summarization (counts, averages)
-- [x] CSV export (via SQL)
-- [x] Theming via JSON config

-- Files:
-- - schema.sql:
--   Defines the complete database structure.
--   The schema is designed for flexibility and scalability, normalized to 3NF.
--   It supports:
--     • Multiple surveys with metadata
--     • Dynamic, ordered questions with multiple types
--     • Conditional branching logic and pagination
--     • Efficient answer storage using a single unified table

--   Table Overview:
--     • participants       → Stores user information, including anonymous entries
--     • surveys            → Stores survey metadata, time limits, and visibility
--     • question_bank      → Stores survey questions, their types, and page/position data
--     • survey_themes      → Stores reusable theme settings per survey (JSON-based)
--     • question_conditions→ Supports conditional logic between questions
--     • survey_attempts    → Tracks each user’s submission attempt
--     • survey_answers     → Stores all types of answers: text, rating, or choice (JSON)

--   Flexible Answer Handling:
--     A single survey_answers table stores responses for all question types.
--     Nullable columns (answer_text, rating_value, answer_choice) ensure clean support
--     for single-choice, multiple-choice, rating, and text-based questions in one place.

-- - data_required.sql:
--   Populates the database with participants, a sample survey, question set,
--   structured answers, and simulated user submissions.

-- - queries.sql:
--   Includes all analytical queries:
--     • Participant and survey statistics
--     • Average ratings and answer breakdown
--     • Pivoted export-ready views of responses
--     • CSV export using SQL (INTO OUTFILE)

-- Additional Notes:
-- - JSON used for flexible options (multi/single choice)
-- - JSON_TABLE used to unpack responses
