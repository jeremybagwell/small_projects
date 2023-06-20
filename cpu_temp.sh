#!/bin/bash

# Check if smartmontools is installed
if ! [ -x "$(command -v smartctl)" ]; then
  echo 'Error: smartmontools is not installed.' >&2
  exit 1
fi

# Get the temperature using smartctl
temp=$(sudo smartctl -a /dev/sda | grep Temperature_Celsius | awk '{print $10}')

# Print the result
echo "CPU Temperature: $temp °C"