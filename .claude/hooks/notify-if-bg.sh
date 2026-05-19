#!/bin/bash
set -eu

# tmux外なら何もしない
[ -z "${TMUX_PANE:-}" ] && exit 0

# stdinからhook eventのJSONを受け取る
input=$(cat)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // empty' 2>/dev/null || echo "")
message=$(printf '%s' "$input" | jq -r '.message // empty' 2>/dev/null || echo "")

# tmuxからwindow/session状態と表示用情報を一括取得
info=$(tmux display-message -p -t "$TMUX_PANE" \
  '#{window_active}|#{session_attached}|#{session_name}|#{window_index}|#{window_name}' 2>/dev/null) || exit 0

IFS='|' read -r active attached sname widx wname <<<"$info"

# activeなwindowかつsessionにclientがattachされている＝ユーザーが見ているはずなので何もしない
if [ "$active" = "1" ] && [ "$attached" != "0" ]; then
  exit 0
fi

title="Claude Code: ${sname}:${widx} ${wname}"

case "$event" in
  Notification)
    if [ -n "$message" ]; then
      body="⏸ $message"
    else
      body="⏸ 入力待ち"
    fi
    ;;
  Stop)
    body="✓ タスク完了"
    ;;
  *)
    body="${event:-event}"
    ;;
esac

# osascriptに渡す前にバックスラッシュとダブルクオートをエスケープ（順序重要）
escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

osascript -e "display notification \"$(escape "$body")\" with title \"$(escape "$title")\""
