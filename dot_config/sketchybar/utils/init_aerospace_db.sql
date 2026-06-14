PRAGMA foreign_keys = ON;

CREATE TABLE monitor(
    id INT PRIMARY KEY,
    display_id INT
);

CREATE TABLE workspace (
    id TEXT PRIMARY KEY,
    monitor_id INT,
    visible BOOLEAN DEFAULT FALSE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(monitor_id) REFERENCES monitor(id)
);

CREATE TRIGGER workspace_updated_at
AFTER UPDATE ON workspace
FOR EACH ROW
BEGIN
    UPDATE workspace SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TABLE app(
    pid VARCHAR PRIMARY KEY,
    name VARCHAR,
    workspace TEXT,
    focused BOOLEAN DEFAULT FALSE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(workspace) REFERENCES workspace(id)
);

CREATE TRIGGER apps_updated_at
AFTER UPDATE ON app
FOR EACH ROW
BEGIN
    UPDATE app SET updated_at = CURRENT_TIMESTAMP WHERE pid = NEW.pid;
END;
