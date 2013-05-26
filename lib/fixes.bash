#!/usr/bin/env bash

# Creates an array from the name of the variable and values
array_from_str () {
  ([ "$#" -lt "1" ] || [ "$#" -gt "2" ]) && return 1

  # Read in the array data
  local DATA
  if [ "$#" -eq "1" ]; then
    DATA="$(cat -)"
  else
    DATA="$2"
  fi

  # Convert the data into an array
  eval "$1=($DATA)"
}

# Unique Array Functions with indicies starting at 0
array_append () {
  eval "$1=(\"\${$1[@]}\" \"$2\")"
}
array_new () {
  unset "$1"
  declare -a "$1"
}
array_at () {
  eval "echo \${$1[$2]}"
}
array_size () {
  eval "echo \${#$1[@]}"
}

# Get colors for the current shell
shell_color () {
  case "$1" in
    red)
      [ "$2" -eq "0" ] && echo '\[\e[0;31m\]' || echo '\[\e[1;31m\]'
      ;;
    green)
      [ "$2" -eq "0" ] && echo '\[\e[0;32m\]' || echo '\[\e[1;32m\]'
      ;;
    yellow)
      [ "$2" -eq "0" ] && echo '\[\e[0;33m\]' || echo '\[\e[1;33m\]'
      ;;
    blue)
      [ "$2" -eq "0" ] && echo '\[\e[0;34m\]' || echo '\[\e[1;34m\]'
      ;;
    pink)
      [ "$2" -eq "0" ] && echo '\[\e[0;35m\]' || echo '\[\e[1;35m\]'
      ;;
    cyan)
      [ "$2" -eq "0" ] && echo '\[\e[0;36m\]' || echo '\[\e[1;36m\]'
      ;;
    white)
      [ "$2" -eq "0" ] && echo '\[\e[0;37m\]' || echo '\[\e[1;37m\]'
      ;;
    *)
      echo '\[\e[0m\]'
  esac
}