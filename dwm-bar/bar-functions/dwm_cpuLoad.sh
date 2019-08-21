#!/bin/sh

load=$(uptime | grep load | awk '{print $8}')
load=${load::-1}

printf "load: %s\n" "$load"
