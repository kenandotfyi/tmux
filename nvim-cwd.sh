#!/bin/bash
##!/bin/bash
#
#pane_id=$(tmux display -p '#{pane_id}')
#file="$HOME/.config/tmux/nvim_cwd_${pane_id}"
#
#if [ -f "$file" ]; then
#  cwd=$(cat "$file")
#  # Show only the last directory
#  basename "$cwd"
#fi
#

pane_id=$(tmux display -p '#{pane_id}')
file="$HOME/.config/tmux/nvim_cwd_${pane_id}"

# Get the PID of the pane
pane_pid=$(tmux list-panes -F "#{pane_id} #{pane_pid}" | awk -v pane="$pane_id" '$1 == pane {print $2}')

# Check if Neovim is running in that process tree
if [ -n "$pane_pid" ] && pgrep -P "$pane_pid" nvim >/dev/null; then
  if [ -f "$file" ]; then
    awk -F/ '{ if (NF>1) print $(NF-1) "/" $NF; else print $NF }' "$file"
  fi
fi
