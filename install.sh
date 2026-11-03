#!/usr/bin/env bash
# Install the pixel-meadow-ui skill into one or more AI coding agents.
#
# Every supported agent reads the open Agent Skills format (a folder with a
# SKILL.md), so installing means copying skills/pixel-meadow-ui into the
# directory each agent scans for skills.
#
# Usage:
#   ./install.sh                         # detect installed agents, install for each (user scope)
#   ./install.sh cursor gemini           # install for specific agents
#   ./install.sh --all                   # install for every supported agent
#   ./install.sh --project cursor        # install into the current project instead of your home dir
#   ./install.sh --uninstall cursor      # remove it again
#   ./install.sh --list                  # show supported agents and their paths
#
# Remote one-liner (no clone needed):
#   curl -fsSL https://raw.githubusercontent.com/lijnati/pixel-meadow-ui/main/install.sh | bash -s -- cursor
set -euo pipefail

SKILL="pixel-meadow-ui"
REPO_URL="https://github.com/lijnati/pixel-meadow-ui.git"
AGENTS="claude codex cursor gemini antigravity copilot opencode windsurf kiro agents"

# agent -> "user-scope dir|project-scope dir|detect dir|label"
agent_info() {
  case "$1" in
    claude)      echo "$HOME/.claude/skills|.claude/skills|$HOME/.claude|Claude Code" ;;
    codex)       echo "$HOME/.agents/skills|.agents/skills|$HOME/.codex|OpenAI Codex" ;;
    cursor)      echo "$HOME/.cursor/skills|.cursor/skills|$HOME/.cursor|Cursor" ;;
    gemini)      echo "$HOME/.gemini/skills|.gemini/skills|$HOME/.gemini|Gemini CLI" ;;
    antigravity) echo "$HOME/.gemini/antigravity/skills|.agent/skills|$HOME/.gemini/antigravity|Google Antigravity" ;;
    copilot)     echo "$HOME/.copilot/skills|.github/skills|$HOME/.copilot|GitHub Copilot" ;;
    opencode)    echo "$HOME/.config/opencode/skills|.opencode/skills|$HOME/.config/opencode|OpenCode" ;;
    windsurf)    echo "$HOME/.codeium/windsurf/skills|.windsurf/skills|$HOME/.codeium/windsurf|Windsurf" ;;
    kiro)        echo "$HOME/.kiro/skills|.kiro/skills|$HOME/.kiro|Kiro" ;;
    agents)      echo "$HOME/.agents/skills|.agents/skills||Any Agent Skills-compatible tool (.agents/skills)" ;;
    *) return 1 ;;
  esac
}

usage() { sed -n '2,17p' "$0" 2>/dev/null | sed 's/^# \{0,1\}//' || true; }

scope="user"; mode="install"; selected=""; all=0
while [ $# -gt 0 ]; do
  case "$1" in
    -p|--project) scope="project" ;;
    -u|--uninstall) mode="uninstall" ;;
    -a|--all) all=1 ;;
    -l|--list) mode="list" ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "Unknown option: $1" >&2; usage; exit 1 ;;
    *)
      a="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
      [ "$a" = "claude-code" ] && a="claude"
      [ "$a" = "gemini-cli" ] && a="gemini"
      [ "$a" = "github-copilot" ] && a="copilot"
      agent_info "$a" >/dev/null || { echo "Unsupported agent: $1 (supported: $AGENTS)" >&2; exit 1; }
      selected="$selected $a" ;;
  esac
  shift
done

if [ "$mode" = "list" ]; then
  printf '%-12s %-48s %s\n' "AGENT" "USER SCOPE" "PROJECT SCOPE"
  for a in $AGENTS; do
    IFS='|' read -r u p _ label <<<"$(agent_info "$a")"
    printf '%-12s %-48s %s\n' "$a" "${u/#$HOME/\~}/$SKILL" "$p/$SKILL"
  done
  exit 0
fi

if [ "$all" = 1 ]; then
  selected="$AGENTS"
elif [ -z "$selected" ]; then
  for a in $AGENTS; do
    IFS='|' read -r _ _ detect _ <<<"$(agent_info "$a")"
    [ -n "$detect" ] && [ -d "$detect" ] && selected="$selected $a"
  done
  if [ -z "$selected" ]; then
    echo "No supported agents detected. Pass one or more of: $AGENTS (or --all)." >&2
    exit 1
  fi
  echo "Detected:$selected"
fi

# Locate the skill source: this checkout, or a fresh shallow clone when piped from curl.
src=""
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -n "$script_dir" ] && [ -f "$script_dir/skills/$SKILL/SKILL.md" ]; then
  src="$script_dir/skills/$SKILL"
elif [ "$mode" = "install" ]; then
  command -v git >/dev/null || { echo "git is required to download the skill." >&2; exit 1; }
  tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
  git clone --depth 1 --quiet "$REPO_URL" "$tmp/repo"
  src="$tmp/repo/skills/$SKILL"
fi

done_dirs=""
for a in $selected; do
  IFS='|' read -r u p _ label <<<"$(agent_info "$a")"
  base="$u"; [ "$scope" = "project" ] && base="$PWD/$p"
  dest="$base/$SKILL"
  case " $done_dirs " in *" $dest "*) echo "  $label: already handled ($dest)"; continue ;; esac
  done_dirs="$done_dirs $dest"
  if [ "$mode" = "uninstall" ]; then
    if [ -d "$dest" ]; then rm -rf "$dest"; echo "  removed  $label: $dest"
    else echo "  skipped  $label: not installed"; fi
  else
    mkdir -p "$base"
    rm -rf "$dest"
    cp -R "$src" "$dest"
    echo "  installed $label: $dest"
  fi
done

if [ "$mode" = "install" ]; then
  echo "Done. Restart your agent, then ask for a cozy pixel-art landing page."
fi
