-- Baseline schema. `users` is the product's account table; `events` is the KPI
-- instrumentation sink — every KPI.md driver-tree node maps to event names here
-- (or to dedicated tables added by later migrations).

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,               -- e.g. 'signup', 'visit', 'subscribe'
    meta TEXT,                        -- JSON payload, nullable
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_events_name_created ON events (name, created_at);
