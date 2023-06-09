#!/bin/bash

# Check if lm-sensors package is installed
if [ -x "$(command -v sensors)" ]; then
    # Get sensor data and store it in an array
    sensor_data=($(sensors))

    # Initialize empty JSON string
    json_string="{}"

    # Loop through each line of the sensor data
    for (( i=0; i<${#sensor_data[@]}; i++ )); do
        # Check if the line contains a colon (indicating a new sensor section)
        if [[ ${sensor_data[$i]} == *:* ]]; then
            # Get the name of the sensor section
            sensor_section=$(echo "${sensor_data[$i]}" | awk -F: '{print $1}')

            # Initialize empty object in JSON string for this sensor section
            json_string=$(echo "$json_string" | jq --arg s "$sensor_section" '. + {($s): {}}')

            # Loop through each line of the sensor data for this section
            for (( j=i+1; j<${#sensor_data[@]}; j++ )); do
                # Check if the line does not contain a colon (indicating a sensor value)
                if [[ ${sensor_data[$j]} != *:* ]]; then
                    # Get the name and value of the sensor reading
                    sensor_reading_name=$(echo "${sensor_data[$j]}" | awk '{print $1}')
                    sensor_reading_value=$(echo "${sensor_data[$j]}" | awk '{print $2}')

                    # Add the sensor reading to the appropriate object in the JSON string
                    json_string=$(echo "$json_string" | jq --arg s "$sensor_section" --arg n "$sensor_reading_name" --arg v "$sensor_reading_value" '.[$s] + {($n): $v}')

                    # Check if the next line contains a colon (indicating a new sensor section)
                    if [[ ${sensor_data[$j+1]} == *:* ]]; then
                        # Exit the inner loop and move on to the next sensor section
                        break
                    fi
                fi
            done
        fi
    done

    # Print the final JSON string
    echo "$json_string"
else
    echo "lm-sensors not found"
fi