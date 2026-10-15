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

「新規claude --rcを起動して」「〇〇のclaude session作って」と言われたら `tmux-claude-rc <ディレクトリパス> <session名>` を実行し、出力されたremote sessionのURLをユーザーに伝える。
tmuxのsession名は、指示の内容に合わせて簡潔に決める。指示に作業内容が無ければproject名にする。
過去にclaudeを使ったディレクトリは `~/.claude/projects/` のディレクトリ名から分かる。ディレクトリ名はpathの `/` と `.` を `-` に置き換えたもので、元のpathを一意には復元できない。`ls` で実在を確かめてからpathを決める。
