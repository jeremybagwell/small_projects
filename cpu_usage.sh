#!/bin/bash

# Check if rsyslog is installed
if ! [ -x "$(command -v logger)" ]; then
  echo 'Error: rsyslog is not installed.' >&2
  exit 1
fi

# Get the current CPU usage
cpu_usage=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2}')

echo "{\"Current CPU Usage\": \"$cpu_usage\"}"

# Get the current Mem usage
mem_usage=$(top -b -n1 | grep "MiB Mem" | awk '{print $4}')

echo "{\"Current Mem Usage\": \"$mem_usage\"}"

# Log the CPU usage with a custom tag and facility level
logger -t CPU_USAGE_SCRIPT -p local0.notice "{\"Current CPU Usage\": \"$cpu_usage\"}"
logger -t CPU_USAGE_SCRIPT -p local0.notice "{\"Current Mem Usage\": \"$mem_usage\"}"
