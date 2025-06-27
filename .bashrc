#!/bin/bash

# Use zsh shell
if [ -t 1 ]; then
  exec zsh
fi
