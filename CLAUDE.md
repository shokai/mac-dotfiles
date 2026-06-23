# Coding Agentガイドライン

# その他の重要なルール

## mainには直接commitしない、pushは明示的な指示を待つ

mainブランチには直接commitしない。mainにいる場合はcommitせず停止し、branch名を提案してユーザーに確認する。
pushはユーザーの明示的な指示を待つ。

## タスク完了後・git commit前に実行するコマンド

作業ディレクトリのプロジェクトにフォーマッタが指定されている場合（例: package.jsonのscripts、Makefile、プロジェクトのCLAUDE.md等）はそちらを優先すること。特に指定がない場合は、コード変更後にすぐに以下を実行すること:

```
oxfmt <changed-file>
```

変更したファイルをformatする。個別ファイルにoxfmtを実行する方がプロジェクト全体にlintを実行するより高速。
