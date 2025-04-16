#!/usr/bin/env bash

CLAUDE_PROMPT="${CODER_MCP_CLAUDE_TASK_PROMPT:-Wait for user input.}"
set -euo pipefail
set -x

if ! command -v claude; then
	echo "claude not installed, exiting"
	exit 1
fi

if ! command -v screen; then
	echo "screen not installed, exiting"
	exit 1
fi

if command -v coder 2>/dev/null; then
	CODER_MCP_APP_STATUS_SLUG=claude-code coder exp mcp configure claude-code /workspaces
fi

touch "${HOME}/.screenrc"

if ! grep -q "^multiuser on$" "${HOME}/.sceenrc"; then
	echo "multiuser on" >> "${HOME}/.screenrc"	
fi

if ! grep -q "^acladd $(whoami)$" "${HOME}/.screenrc"; then
	echo "acladd $(whoami)" >> "${HOME}/.screenrc"
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

screen -U -dmS claude-code bash -c '
	cd /workspaces
	claude --dangerously-skip-permissions | tee -a "${HOME}/.claude-code.log"
	exec bash
'
screen -S claude-code -X stuff "${CLAUDE_PROMPT}"
sleep 5
screen -S claude-code -X stuff "^M"
