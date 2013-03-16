#!/bin/bash

PROJECT=pastebit

tmux_session=${PROJECT}_dev
project_root="$(dirname $(readlink -f $0))"

pushd $project_root >/dev/null

tmux has-session -t $tmux_session
if [ $? != 0 ]; then
  export TERM=xterm-256color # Find a less janky way to fix this

  echo "Setting up new tmux session '$tmux_session'"
  tmux new-session -s $tmux_session -n tests -d

  # Create window 1: Tests & git status
  tmux send-keys -t ${tmux_session}:1 'guard' C-m
  tmux split-window -t $tmux_session -p 25 -h
  tmux send-keys -t ${tmux_session}:1 'watch -c -n 5 -t git status -sb' C-m

  # Create window 2: Web server logs
  tmux new-window -t $tmux_session -n webserver
  tmux send-keys -t ${tmux_session}:2 'bundle exec rackup -p 4567' C-m

  # Create Window 3: shell for playing in
  tmux new-window -t $tmux_session -n shell
  tmux send-keys -t ${tmux_session}:3 '(sleep 5 && chromium-browser localhost:4567) &' C-m
  tmux send-keys -t ${tmux_session}:3 'gvim -geometry 500x500' C-m
  tmux send-keys -t ${tmux_session}:3 'clear; ls -l' C-m

  tmux select-window -t ${tmux_session}:1
fi
tmux attach -t $tmux_session

popd >/dev/null
