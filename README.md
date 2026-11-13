我想要在公司也像家裡抓同一組 Skill 來用，但因為公司政策，我只能先 Public 再 Clone `;)`

---

### 怎麼用

同一組 Skill 存了兩份，Clone 後把需要的資料夾複製到專案根目錄就能用：

| 資料夾 | 給誰用 |
| --- | --- |
| `.agents/skills/` | Codex |
| `.claude/skills/` | Claude Code |

專案裡已經有 `.claude/` 的話，只複製 `.claude/skills/`，不要整個覆蓋掉專案原本的設定。

### 維護

- `.agents/skills/` 是正本，只改這份；`.claude/skills/` 是同步產生的，手動修改會被覆蓋
- 和 Claude Code 內建指令撞名的 Skill，只在 `.claude/skills/` 改名，其他 Skill 裡的引用也會一併替換（清單在腳本的 `RENAMES`）：
  - `code-review` → `code-review-matt`
- `answer-me-with-html` 改成只能手動觸發（`/answer-me-with-html`）：上游預設會主動大量產生頁面，所以在 SKILL.md 加了 `disable-model-invocation: true`，並新增 `agents/openai.yaml` 關掉 Codex 的自動觸發。從上游更新時要保留這兩處
- 同步：`scripts/sync-skills.sh`；只檢查：`scripts/sync-skills.sh --check`
- 啟用 pre-commit hook 後，commit 時會自動同步並加入 commit（每個 Clone 執行一次）：`git config core.hooksPath .githooks`

---

### 俺拿來用的香香 Skills 來源庫

- [mattpocock/skills](https://github.com/mattpocock/skills)
- [duolahypercho/andrej-karpathy-skills](https://github.com/duolahypercho/andrej-karpathy-skills)
- [obra/superpowers](https://github.com/obra/superpowers)
- [kevintsengtw/dotnet-testing Agent Orchestration — Lite](https://github.com/kevintsengtw/dotnet-testing-agent-orchestration-claude-lite)
- [larashero3-dotcom/lieflat-less-ai-tone](https://github.com/larashero3-dotcom/lieflat-less-ai-tone)
- [AllanYiin/Amon — skill-creator-advanced](https://github.com/AllanYiin/Amon/tree/main/src/amon/resources/skills/skill-creator-advanced)
- [QingYunA/answer-me-with-html](https://github.com/QingYunA/answer-me-with-html)
- [dotnet/skills](https://github.com/dotnet/skills)（只收 dotnet、dotnet-data、dotnet-aspnetcore、dotnet-upgrade、dotnet-nuget 中的部分 Skill）