#!/usr/bin/env bash
# Package the skill into dist/pixel-meadow-ui.skill (for upload in the Claude apps)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist
python3 - <<'PY'
import zipfile, pathlib
root = pathlib.Path("skills/pixel-meadow-ui")
name = "pixel-meadow-ui"
with zipfile.ZipFile(f"dist/{name}.skill", "w", zipfile.ZIP_DEFLATED) as z:
    for p in sorted(root.rglob("*")):
        if p.is_file():
            z.write(p, f"{name}/{p.relative_to(root).as_posix()}")
print(f"built dist/{name}.skill")
PY
