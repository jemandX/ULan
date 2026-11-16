# Brief

**Question:** Can the ULan launcher set its Windows command window icon from a project-root icon.ico without disrupting the server startup?

**Purpose:** Make the command window used to run ULan display the user's custom icon.

**Targets:**
- C:\Users\Mats\Documents\ULan-dev\ULan

**Constraints:**
- Only edit project files in place.
- Use the icon file named icon.ico supplied by the user; do not create or replace it.
- Preserve the server launch behavior and existing data.

**Done when:** The Windows launch console attempts to use the adjacent icon.ico when present, while continuing to launch normally if it is absent or unsupported; check the result with rebuild_check.
