# Coding Agentガイドライン

## mainには直接commitしない、pushは明示的な指示を待つ

mainブランチには直接commitしない。mainにいる場合はcommitせず停止し、branch名を提案してユーザーに確認する。
pushはユーザーの明示的な指示を待つ。

## タスク完了後・git commit前に実行するコマンド

作業ディレクトリのプロジェクトにフォーマッタが指定されている場合（例: package.jsonのscripts、Makefile、プロジェクトのCLAUDE.md等）はそちらを優先すること。特に指定がない場合は、コード変更後にすぐに以下を実行すること:

```
oxfmt <changed-file>
```

変更したファイルをformatする。個別ファイルにoxfmtを実行する方がプロジェクト全体にlintを実行するより高速。

## 新規claude --rcの起動

「新規claude --rcを起動して」「〇〇のclaude session作って」「remote claude接続を作って」と言われたら、`tmux-claude-rc` で起動し、出力されたremote sessionのURLをユーザーに伝える。

過去にclaudeを使ったディレクトリは `~/.claude/projects/` のディレクトリ名から分かる。ディレクトリ名はpathの `/` と `.` を `-` に置き換えたもので、元のpathを一意には復元できない。`ls` で実在を確かめてからpathを決める。

既存のtmux sessionにwindowとして足すか、新規のtmux sessionを作るかを、AskUserQuestionでユーザーに確認する。既存sessionの選択肢には、起動するディレクトリで作業しているsessionを挙げる。

- 既存sessionに足す: `tmux-claude-rc -w <ディレクトリパス> <session名>`
- 新規sessionを作る: `tmux-claude-rc <ディレクトリパス> <session名>`。session名は指示の内容に合わせて簡潔に決める。指示に作業内容が無ければproject名にする
