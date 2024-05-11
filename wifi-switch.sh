#!/bin/bash

CONFIG_FILE="/boot/firmware/config.txt"
TARGET_LINE="dtoverlay=disable-wifi"

# Find the first instance of the target line
LINE_NUMBER=$(grep -n "$TARGET_LINE" "$CONFIG_FILE" | head -n 1 | cut -d ':' -f 1)

if [[ -n $LINE_NUMBER ]]; then
    # Check if the line is commented
    if sed -n "${LINE_NUMBER}p" "$CONFIG_FILE" | grep -q "^#.*$TARGET_LINE"; then
        # If found commented, uncomment the line
        sudo sed -i "${LINE_NUMBER}s/^#//" "$CONFIG_FILE"
        echo "External WiFi enabled. Reboot to apply changes."
    else
        # If not found commented, comment the line
        sudo sed -i "${LINE_NUMBER}s/^/#/" "$CONFIG_FILE"
        echo "External WiFi disabled. Reboot to apply changes."
    fi
else
    echo "Target line not found in the configuration file."
fi
