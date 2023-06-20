#!/bin/bash

# Get the public IP address
public_ip=$(curl -s https://api.ipify.org)

# Call the ipapi.co API to get location data
location_data=$(curl -s "https://ipapi.co/$public_ip/json/")

# Extract the latitude and longitude values
latitude=$(echo $location_data | jq -r '.latitude')
longitude=$(echo $location_data | jq -r '.longitude')

# Output the results
echo $location_data
echo "Latitude: $latitude"
echo "Longitude: $longitude"