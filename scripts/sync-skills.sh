#!/bin/sh
# 以 .agents/skills（正本，給 Codex）為準，完整同步到 .claude/skills（給 Claude Code）。
# 只改 .agents/skills；.claude/skills 是產生出來的，手動修改會在下次同步時被覆蓋。
#
# 用法：
#   scripts/sync-skills.sh          同步
#   scripts/sync-skills.sh --check  只檢查兩邊是否一致，不一致時回傳 1
set -eu

ROOT=$(git rev-parse --show-toplevel)
SRC="$ROOT/.agents/skills"
DST="$ROOT/.claude/skills"

if [ ! -d "$SRC" ]; then
  echo "找不到 $SRC" >&2
  exit 1
fi

if [ "${1:-}" = "--check" ]; then
  if diff -r -q "$SRC" "$DST" >/dev/null 2>&1; then
    echo ".claude/skills 與 .agents/skills 一致"
    exit 0
  fi
  echo ".claude/skills 與 .agents/skills 不一致，請執行 scripts/sync-skills.sh" >&2
  diff -r -q "$SRC" "$DST" >&2 || true
  exit 1
fi

mkdir -p "$ROOT/.claude"
rm -rf "$DST"
cp -R "$SRC" "$DST"
echo "已同步 $(ls -1 "$DST" | wc -l | tr -d ' ') 個 Skill 到 .claude/skills"
