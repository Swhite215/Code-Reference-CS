# Example WHILE loop

while [[ "$REPLY" != 0 ]]; do
    clear
	
    cat << EOF
	Please Select:
	
	1. Display System Information
	2. Display Disk Space
	3. Display Home Space Utilization
	0. Quit

EOF

    read -p "Enter selection [0-3] > "

    if [[ "$REPLY" =~ ^[0-3]$ ]]; then
        if [[ $REPLY == 1 ]]; then
            echo "Hostname: $HOSTNAME"
            uptime
            sleep 3
        fi

        if [[ $REPLY == 2 ]]; then
            df -h
            sleep 3
        fi

        if [[ $REPLY == 3 ]]; then
            if [[ "$(id -u)" -eq 0 ]]; then
                echo "Home Space Utilization (All Users)"
                du -sh /home/*
            else
                echo "Home Space Utilization ($USER)"
                du -sh /home/*
            fi
            sleep 3
        fi
    else 
        echo "Invalid entry."
        sleep 3
    fi
done
echo "Program terminated..."
