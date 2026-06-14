#!/bin/bash
#This is going to bootstrap the attendance_tracker project
read -p "Enter your project name: " PROJECT_NAME
DIR_NAME="attendance_tracker_${PROJECT_NAME}"
cleanup() {
    echo ""
    echo "Interrupted! Archiving current progress..."
    tar -czf "${DIR_NAME}_archive.tar.gz" "$DIR_NAME"
    rm -rf "$DIR_NAME"
    echo "Saved as ${DIR_NAME}_archive.tar.gz — incomplete folder removed."
    exit 1
}

trap cleanup SIGINT
mkdir -p "$DIR_NAME"/Helpers "$DIR_NAME"/reports
cp attendance_checker.py "$DIR_NAME"/attendance_checker.py
cp assets.csv "$DIR_NAME"/Helpers/assets.csv
cp config.json "$DIR_NAME"/Helpers/config.json
cp reports.log "$DIR_NAME"/reports/reports.log
	read -p "Do you want to update attendance thresholds? (y/n): " UPDATE_CHOICE
if [ "$UPDATE_CHOICE" = "y" ]; then
    read -p "Enter new Warning threshold (default 75): " WARNING
    read -p "Enter new Failure threshold (default 50): " FAILURE

    if [[ "$WARNING" =~ ^[0-9]+$ ]] && [[ "$FAILURE" =~ ^[0-9]+$ ]]; then
        sed -i "s/\"warning\": [0-9]*/\"warning\": $WARNING/" "$DIR_NAME"/Helpers/config.json
        sed -i "s/\"failure\": [0-9]*/\"failure\": $FAILURE/" "$DIR_NAME"/Helpers/config.json
        echo "Thresholds updated successfully."
    else
        echo "Invalid input — thresholds were not numbers. Keeping default values."
    fi
fi
echo ""
echo "Running environment health check..."

if python3 --version &> /dev/null; then
    echo "Health Check OK: python3 is installed ($(python3 --version))"
else
    echo "Health Check WARNING: python3 was not found on this system."
fi

echo "Setup complete! Project created at: $DIR_NAME"
