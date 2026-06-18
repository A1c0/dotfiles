PRAGMA foreign_keys = ON;

-- =====================================================================
-- TABLES
-- =====================================================================

CREATE TABLE monitor (
    id         INT PRIMARY KEY,
    display_id INT
);

CREATE TABLE workspace (
    id         TEXT PRIMARY KEY,
    monitor_id INT,
    visible    BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(monitor_id) REFERENCES monitor(id)
);

CREATE TABLE app (
    pid        VARCHAR PRIMARY KEY,
    name       VARCHAR,
    workspace  TEXT,
    focused    BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(workspace) REFERENCES workspace(id)
);

-- =====================================================================
-- TRIGGERS
-- =====================================================================

CREATE TRIGGER app_single_focus
AFTER UPDATE ON app
FOR EACH ROW
WHEN NEW.focused = TRUE AND OLD.focused = FALSE
BEGIN
    UPDATE app SET focused = FALSE
    WHERE focused = TRUE AND pid <> NEW.pid;
END;

CREATE TRIGGER workspace_single_visible
AFTER UPDATE ON workspace
FOR EACH ROW
WHEN NEW.visible = TRUE AND OLD.visible = FALSE
BEGIN
    UPDATE workspace SET visible = FALSE
    WHERE visible = TRUE AND monitor_id = NEW.monitor_id AND id <> NEW.id;
END;

CREATE TRIGGER app_focus_shows_workspace
AFTER UPDATE ON app
FOR EACH ROW
WHEN NEW.focused = TRUE
  AND NEW.workspace IS NOT NULL
  AND (OLD.focused = FALSE OR OLD.workspace IS NOT NEW.workspace)
BEGIN
    -- 1) masquer les voisins sur le meme monitor
    UPDATE workspace SET visible = FALSE
    WHERE visible = TRUE
      AND id <> NEW.workspace
      AND monitor_id = (SELECT monitor_id FROM workspace WHERE id = NEW.workspace);
    -- 2) rendre visible le workspace de l'app
    UPDATE workspace SET visible = TRUE
    WHERE id = NEW.workspace AND visible = FALSE;
END;
