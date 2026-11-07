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