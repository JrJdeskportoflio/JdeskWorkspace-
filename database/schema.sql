-- Users
CREATE TABLE IF NOT EXISTS users (
  id         TEXT PRIMARY KEY,
  email      TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  display_name TEXT,
  role       TEXT DEFAULT 'member',
  created_at TEXT
);

-- Employees
CREATE TABLE IF NOT EXISTS employees (
  id         TEXT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name  TEXT NOT NULL,
  email      TEXT UNIQUE NOT NULL,
  dept       TEXT,
  position   TEXT,
  start_date TEXT,
  status     TEXT DEFAULT 'Active',
  phone      TEXT,
  created_at TEXT
);

-- Attendance
CREATE TABLE IF NOT EXISTS attendance (
  id          TEXT PRIMARY KEY,
  employee_id TEXT,
  date        TEXT NOT NULL,
  time_in     TEXT,
  time_out    TEXT,
  status      TEXT DEFAULT 'Present',
  created_at  TEXT
);

-- Leave Requests
CREATE TABLE IF NOT EXISTS leave_requests (
  id          TEXT PRIMARY KEY,
  employee_id TEXT,
  name        TEXT,
  type        TEXT,
  from_date   TEXT,
  to_date     TEXT,
  days        INTEGER,
  reason      TEXT,
  status      TEXT DEFAULT 'Pending',
  filed_date  TEXT
);

-- Payroll Ledger
CREATE TABLE IF NOT EXISTS payroll_ledger (
  id          TEXT PRIMARY KEY,
  employee_id TEXT,
  period      TEXT,
  basic_pay   REAL,
  overtime    REAL,
  allowances  REAL,
  deductions  REAL,
  total_pay   REAL,
  status      TEXT DEFAULT 'Draft',
  created_at  TEXT
);

-- Performance Reviews
CREATE TABLE IF NOT EXISTS performance_reviews (
  id          TEXT PRIMARY KEY,
  employee_id TEXT,
  period      TEXT,
  score       REAL,
  comments    TEXT,
  goals       TEXT,
  created_at  TEXT
);

-- Job Postings
CREATE TABLE IF NOT EXISTS job_postings (
  id          TEXT PRIMARY KEY,
  title       TEXT NOT NULL,
  dept        TEXT,
  type        TEXT,
  location    TEXT,
  salary      TEXT,
  description TEXT,
  status      TEXT DEFAULT 'Open',
  posted_date TEXT
);

-- Applicants
CREATE TABLE IF NOT EXISTS applicants (
  id          TEXT PRIMARY KEY,
  job_id      TEXT,
  name        TEXT,
  email       TEXT,
  phone       TEXT,
  stage       TEXT DEFAULT 'Applied',
  applied_date TEXT
);

-- Support Tickets
CREATE TABLE IF NOT EXISTS tickets (
  id           TEXT PRIMARY KEY,
  subject      TEXT NOT NULL,
  category     TEXT,
  priority     TEXT DEFAULT 'Normal',
  description  TEXT,
  submitted_by TEXT,
  assigned_to  TEXT,
  status       TEXT DEFAULT 'Open',
  created_at   TEXT
);

-- Documents
CREATE TABLE IF NOT EXISTS documents (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  category    TEXT,
  description TEXT,
  file_url    TEXT,
  file_size   INTEGER,
  file_type   TEXT,
  uploaded_by TEXT,
  uploaded_at TEXT
);

-- Messages
CREATE TABLE IF NOT EXISTS messages (
  id           TEXT PRIMARY KEY,
  thread_id    TEXT,
  sender_token TEXT,
  text         TEXT,
  attachment_url TEXT,
  created_at   TEXT
);

-- Timeline Posts
CREATE TABLE IF NOT EXISTS timeline_posts (
  id           TEXT PRIMARY KEY,
  author_token TEXT,
  author_name  TEXT,
  author_role  TEXT,
  text         TEXT,
  created_at   TEXT
);

-- Timeline Reactions
CREATE TABLE IF NOT EXISTS timeline_reactions (
  id           TEXT PRIMARY KEY,
  post_id      TEXT,
  user_token   TEXT,
  emoji        TEXT
);

-- Timeline Comments
CREATE TABLE IF NOT EXISTS timeline_comments (
  id           TEXT PRIMARY KEY,
  post_id      TEXT,
  user_token   TEXT,
  text         TEXT,
  created_at   TEXT
);

-- Surveys
CREATE TABLE IF NOT EXISTS surveys (
  id         TEXT PRIMARY KEY,
  title      TEXT,
  questions  TEXT,
  due_date   TEXT,
  created_by TEXT,
  created_at TEXT
);

-- Survey Responses
CREATE TABLE IF NOT EXISTS survey_responses (
  id               TEXT PRIMARY KEY,
  survey_id        TEXT,
  respondent_token TEXT,
  answers          TEXT,
  submitted_at     TEXT
);

-- Knowledge Articles
CREATE TABLE IF NOT EXISTS knowledge_articles (
  id           TEXT PRIMARY KEY,
  title        TEXT NOT NULL,
  category     TEXT,
  content      TEXT,
  tags         TEXT,
  author_token TEXT,
  author_name  TEXT,
  created_at   TEXT,
  updated_at   TEXT
);

-- Integrations
CREATE TABLE IF NOT EXISTS integrations (
  id           TEXT PRIMARY KEY,
  type         TEXT,
  label        TEXT,
  config       TEXT,
  status       TEXT DEFAULT 'active',
  connected_at TEXT
);

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
  id         TEXT PRIMARY KEY,
  user_token TEXT NOT NULL,
  type       TEXT NOT NULL,
  text       TEXT NOT NULL,
  href       TEXT DEFAULT '#',
  unread     INTEGER DEFAULT 1,
  created_at TEXT NOT NULL
);

-- Reports (metadata log for generated reports)
CREATE TABLE IF NOT EXISTS reports (
  id           TEXT PRIMARY KEY,
  name         TEXT NOT NULL,
  type         TEXT NOT NULL,
  format       TEXT NOT NULL,
  org_id       TEXT,
  date_from    TEXT,
  date_to      TEXT,
  r2_key       TEXT,
  rows         INTEGER DEFAULT 0,
  status       TEXT DEFAULT 'ready',
  generated_at TEXT NOT NULL
);
