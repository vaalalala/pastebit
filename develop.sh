#!/bin/bash

PROJECT=pastebit

tmux_session=${PROJECT}_dev
project_root="$(dirname $(readlink -f $0))"

pushd $project_root >/dev/null

tmux has-session -t $tmux_session
if [ $? != 0 ]; then
  echo "Setting up new tmux session '$tmux_session'"

  tmux new-session -s $tmux_session -n monitoring -d

  tmux send-keys -t ${tmux_session}:1 'guard' C-m
  tmux split-window -t $tmux_session -p 20 -h
  tmux send-keys -t ${tmux_session}:1.2 'bundle exec rackup -p 4567' C-m

  tmux new-window -t $tmux_session -n shell
  tmux split-window -t ${tmux_session}:2 -h -p 20
  tmux send-keys -t ${tmux_session}:2.2 'watch -n 5 -t git status -sb' C-m

  tmux select-window -t ${tmux_session}:1
  gvim
fi
tmux attach -t $tmux_session

popd >/dev/null
