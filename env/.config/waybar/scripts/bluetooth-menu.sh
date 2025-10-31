#!/bin/bash

action=$(echo -e "Scan & Connect\nShow Paired Devices\nToggle Power" | wofi --dmenu -p "Bluetooth")

case $action in
    "Scan & Connect")
        notify-send "Bluetooth" "Scanning for 15 seconds..."
        
        # Create temp file for scan output
        tmpfile=$(mktemp)
        
        # Start bluetoothctl and scan
        {
            echo "power on"
            echo "scan on"
            sleep 15
            echo "devices"
            echo "scan off"
            echo "exit"
        } | bluetoothctl > "$tmpfile"
        
        # Parse devices - strip ANSI codes first, then filter clean Device lines only
        device=$(sed 's/\x1b\[[0-9;]*m//g' "$tmpfile" | \
                 grep "^Device" | \
                 grep -E "Device ([0-9A-F]{2}:){5}[0-9A-F]{2}" | \
                 sort -u | \
                 wofi --dmenu -p "Select device" | \
                 awk '{print $2}')
        
        rm "$tmpfile"
        
        if [ -n "$device" ]; then
            notify-send "Bluetooth" "Connecting to $device..."
            
            # Keep scan on while pairing
            {
                echo "power on"
                echo "scan on"
                sleep 2
                echo "pair $device"
                sleep 3
                echo "trust $device"
                sleep 1
                echo "connect $device"
                sleep 2
                echo "scan off"
                echo "exit"
            } | bluetoothctl > /tmp/bt-pair.log 2>&1
            
            if grep -q "Connection successful" /tmp/bt-pair.log; then
                notify-send "Bluetooth" "✓ Connected successfully!"
            else
                notify-send "Bluetooth" "Check status - see /tmp/bt-pair.log"
            fi
        fi
        ;;
    
    "Show Paired Devices")
        device=$(bluetoothctl devices Paired | \
                 sed 's/\x1b\[[0-9;]*m//g' | \
                 grep "^Device" | \
                 sort -u | \
                 wofi --dmenu -p "Paired devices" | \
                 awk '{print $2}')
        if [ -n "$device" ]; then
            notify-send "Bluetooth" "Connecting..."
            if bluetoothctl connect "$device"; then
                notify-send "Bluetooth" "✓ Connected!"
            else
                notify-send "Bluetooth" "✗ Connection failed"
            fi
        fi
        ;;
    
    "Toggle Power")
        if bluetoothctl show | grep -q "Powered: yes"; then
            bluetoothctl power off && notify-send "Bluetooth" "Off"
        else
            bluetoothctl power on && notify-send "Bluetooth" "On"
        fi
        ;;
esac
