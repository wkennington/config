#!/usr/bin/env bash

# Creates an array from the name of the variable and values
to_array () {
  ([ "$#" -lt "1" ] || [ "$#" -gt "2" ]) && return 1

  # Read in the array data
  local DATA
  if [ "$#" -eq "1" ]; then
    DATA="$(cat -)"
  else
    DATA="$2"
  fi

  # Convert the data into an array
  if [ "$(shell)" = "zsh" ]; then
    eval "$1=($DATA)"
  elif [ "$(shell)" = "sh" ] || [ "$(shell)" = "bash" ]; then
    eval "$1=\"$DATA\""
  else
    return 1
  fi
}
