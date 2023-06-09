#!/bin/bash

# get the public IP address
public_ip=$(curl -s https://api.ipify.org)

# send request to API and save response
response=$(curl -s "https://ipapi.co/$public_ip/json/")

# parse response to extract location information
city=$(echo $response | jq -r '.city')
region=$(echo $response | jq -r '.region')
country=$(echo $response | jq -r '.country_name')

# output results
echo "Location: $city, $region, $country"