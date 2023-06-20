#!/bin/bash

# Get system uptime and load average
uptime_output=$(uptime)

# Extract each component of the uptime output
uptime_days=$(echo "${uptime_output}" | awk '{print $3}')
uptime_hours=$(echo "${uptime_output}" | awk '{print $5}' | cut -d: -f1)
uptime_minutes=$(echo "${uptime_output}" | awk '{print $5}' | cut -d: -f2 | sed 's/^0*//' | sed 's/,$//')
load_average_1m=$(echo "${uptime_output}" | awk '{print $10}' | cut -d, -f1)
load_average_5m=$(echo "${uptime_output}" | awk '{print $11}' | cut -d, -f1)
load_average_15m=$(echo "${uptime_output}" | awk '{print $12}')

# Get CPU usage percentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100-$1}')

# Get memory usage percentage
ram_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')

# Get the public IP address
public_ip=$(curl -s https://api.ipify.org)

echo $public_ip

# Call the ipapi.co API to get location data
location_data=$(curl -s "https://ipapi.co/$public_ip/json/")

echo $location_data

# Extract the latitude and longitude values
latitude=$(echo $location_data | jq -r '.latitude')
longitude=$(echo $location_data | jq -r '.longitude')
city=$(echo $location_data | jq -r '.city')
region=$(echo $location_data | jq -r '.region')
region_code=$(echo $location_data | jq -r '.region_code')
country=$(echo $location_data | jq -r '.country')
country_name=$(echo $location_data | jq -r '.country_name')
country_area=$(echo $location_data | jq -r '.country_area')
country_population=$(echo $location_data | jq -r '.country_population')
timezone=$(echo $location_data | jq -r '.timezone')
utc_offset=$(echo $location_data | jq -r '.utc_offset')
postal=$(echo $location_data | jq -r '.country_name')



json_string="MNAVJ {"
json_string+="\"evt\": \"SystemStats\", "
json_string+="\"deviceId\": \"FOOBAR2\", "
json_string+="\"cpu_usage\": $cpu_usage, "
json_string+="\"ram_usage\": $ram_usage, "
json_string+="\"uptime_days\": $uptime_days, "
json_string+="\"uptime_hours\": $uptime_hours, "
json_string+="\"uptime_minutes\": $uptime_minutes, "
json_string+="\"load_average_1m\": $load_average_1m, "
json_string+="\"load_average_5m\": $load_average_5m, "
json_string+="\"load_average_15m\": $load_average_15m, "
json_string+="\"ip_address\": \"$public_ip\", "
json_string+="\"location_data\": { "
json_string+="\"latitude\": $latitude, "
json_string+="\"longitude\": $longitude, "
json_string+="\"city\": \"$city\", "
json_string+="\"region\": \"$region\", "
json_string+="\"region_code\": \"$region_code\", "
json_string+="\"country\": \"$country\", "
json_string+="\"country_name\": \"$country_name\", "
json_string+="\"country_area\": $country_area, "
json_string+="\"country_population\": $country_population, "
json_string+="\"timezone\": \"$timezone\", "
json_string+="\"utc_offset\": \"$utc_offset\", "
json_string+="\"postal\": \"$postal\""
json_string+="}}"

echo $json_string

logger -p local7.notice "$json_string"


# # Get disk usage
# df -h

# # List running processes sorted by memory usage
# ps aux --sort=-%mem | head

# # Get network interface information
# ifconfig -a

# # Get network connections information
# netstat -an

