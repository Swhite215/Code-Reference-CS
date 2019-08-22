DELAY=3

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

    case "$REPLY" in
    0)  echo "Program terminated..."
        exit
        ;;
    1) echo "Hostname: $HOSTNAME"
        uptime
        sleep $DELAY 
        ;;
    2) df -h
        sleep $DELAY 
        ;;
    3) if [[ "$(id -u)" -eq 0 ]]; then
            echo "Home Space Utilization (All Users)"
            du -sh /home/*
            sleep $DELAY 
        else
            echo "Home Space Utilization ($USER)"
            du -sh /home/*
            sleep $DELAY 
        fi
        ;;
    *) echo "Invalid entry" >&2
        exit 1
        ;;
    
    esac

done
echo "Program terminated..."
