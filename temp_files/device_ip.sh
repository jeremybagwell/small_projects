#!/bin/bash

# Get the public IP address
public_ip=$(curl -s https://api.ipify.org)

echo "Public IP: $public_ip"