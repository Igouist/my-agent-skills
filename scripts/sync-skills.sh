#!/bin/sh
# 以 .agents/skills（正本，給 Codex）為準，完整同步到 .claude/skills（給 Claude Code）。
# 只改 .agents/skills；.claude/skills 是產生出來的，手動修改會在下次同步時被覆蓋。
#
# 同步時會把和 Claude Code 內建指令撞名的 Skill 改名（見 RENAMES），
# 並一併替換其他 Skill 裡對它的引用。.agents/skills 維持和上游一致。
#
# 用法：
#   scripts/sync-skills.sh          同步
#   scripts/sync-skills.sh --check  只檢查 .claude/skills 是否為最新，不是時回傳 1
set -eu

# 格式：「原名:新名」，以空白分隔
RENAMES="code-review:code-review-matt"

ROOT=$(git rev-parse --show-toplevel)
SRC="$ROOT/.agents/skills"
DST="$ROOT/.claude/skills"

if [ ! -d "$SRC" ]; then
  echo "找不到 $SRC" >&2
  exit 1
fi

# 先在暫存目錄產生預期結果
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
OUT="$TMP/skills"
cp -R "$SRC" "$OUT"

for pair in $RENAMES; do
  from=${pair%%:*}
  to=${pair#*:}
  [ -d "$OUT/$from" ] || continue
  mv "$OUT/$from" "$OUT/$to"
  # 只替換完整名稱，避免誤改 receiving-code-review 這類較長的名稱
  find "$OUT" -type f \( -name '*.md' -o -name '*.yaml' \) -exec \
    sed -i "s/\(^\|[^a-z0-9-]\)$from\([^a-z0-9-]\|\$\)/\1$to\2/g" {} +
done

if [ "${1:-}" = "--check" ]; then
  if diff -r -q --strip-trailing-cr "$OUT" "$DST" >/dev/null 2>&1; then
    echo ".claude/skills 已是最新"
    exit 0
  fi
  echo ".claude/skills 不是最新，請執行 scripts/sync-skills.sh" >&2
  diff -r -q --strip-trailing-cr "$OUT" "$DST" >&2 || true
  exit 1
fi

mkdir -p "$ROOT/.claude"
rm -rf "$DST"
cp -R "$OUT" "$DST"
echo "已同步 $(ls -1 "$DST" | wc -l | tr -d ' ') 個 Skill 到 .claude/skills（改名：$RENAMES）"
