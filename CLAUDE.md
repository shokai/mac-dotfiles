# Coding Agentガイドライン

Claude Codeでユーザーがソフトウェア開発を始めた時にsoftware-factory-mode skillが呼び出されていなければ、「software-factory-mode skillを使う場合は、skillを呼び出してください」とユーザーに伝える。

## タスク完了後・git commit前に実行するコマンド

作業ディレクトリのプロジェクトにフォーマッタが指定されている場合（例: package.jsonのscripts、Makefile、プロジェクトのCLAUDE.md等）はそちらを優先すること。特に指定がない場合は、コード変更後にすぐに以下を実行すること:

```
oxfmt <changed-file>
```

変更したファイルをformatする。個別ファイルにoxfmtを実行する方がプロジェクト全体にlintを実行するより高速。
