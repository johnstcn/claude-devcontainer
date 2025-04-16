#!/usr/bin/env bash
set -euo pipefail
set -x

if ! command -v code-server; then
	exit 1
fi

if ! command -v screen; then
	echo "screen not installed, exiting"
	exit 1
fi

if [[ ! -d /workspaces ]]; then
	exit 1
fi

touch "${HOME}/.screenrc"

if ! grep -q "^multiuser on$" "${HOME}/.sceenrc"; then
	echo "multiuser on" >> "${HOME}/.screenrc"	
fi

if ! grep -q "^acladd $(whoami)$" "${HOME}/.screenrc"; then
	echo "acladd $(whoami)" >> "${HOME}/.screenrc"
fi

screen -U -dmS code-server bash -c '
	code-server --auth none --bind-addr 0.0.0.0:33337 /workspaces
	exec bash
'

