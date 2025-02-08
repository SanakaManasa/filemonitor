#!/bin/bash

# Configuration
MONITOR_DIR="$HOME/OneDrive/Desktop/file_monitoring"  # Change this to the actual directory
SNAPSHOT_FILE="snapshot.md5"
LOG_FILE="filemonitor.log"

# Function to log messages with timestamps
log_message() {
    echo "$(date +"%a, %b %d, %Y %I:%M:%S %p"): $1" | tee -a "$LOG_FILE"
}

# Check disk space
check_disk_usage() {
    USAGE=$(df -h | grep "C:/Program Files/Git" | awk '{print $5}')
    if [[ -n "$USAGE" ]]; then
        log_message "Disk space usage is under control. Current usage: $USAGE"
    else
        log_message "Error: Unable to retrieve valid disk usage"
    fi
}

# Create a snapshot of monitored files
create_snapshot() {
    if [ ! -d "$MONITOR_DIR" ]; then
        log_message "Error: Directory $MONITOR_DIR does not exist!"
        return
    fi
    find "$MONITOR_DIR" -type f -exec md5sum {} \; > "$SNAPSHOT_FILE"
    log_message "Snapshot created and saved."
}

# Check file integrity
check_integrity() {
    if [ ! -f "$SNAPSHOT_FILE" ]; then
        log_message "No previous snapshot found. Creating a new one."
        create_snapshot
        return
    fi

    TEMP_FILE="temp_snapshot.md5"
    find "$MONITOR_DIR" -type f -exec md5sum {} \; > "$TEMP_FILE"

    CHANGES=$(diff "$SNAPSHOT_FILE" "$TEMP_FILE")

    if [ -z "$CHANGES" ]; then
        log_message "Integrity check complete. No changes detected."
    else
        log_message "WARNING: File changes detected!"
        echo "$CHANGES" >> "$LOG_FILE"
    fi

    mv "$TEMP_FILE" "$SNAPSHOT_FILE"
}

# Main execution
log_message "Starting file integrity monitoring..."
check_integrity
check_disk_usage
create_snapshot
log_message "File integrity monitoring complete!"
