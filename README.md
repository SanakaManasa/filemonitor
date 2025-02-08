File Integrity Monitoring Script
Configuration:
MONITOR_DIR: This is the directory you want to monitor for file changes. Change this to the desired path.
SNAPSHOT_FILE: Stores the MD5 hash snapshot of all files in the monitored directory.
LOG_FILE: Logs all messages, including any detected changes or errors.

Functions:

log_message():
Logs messages with a timestamp in the log file.
Uses tee to print the log to the terminal and append to the log file.

check_disk_usage():
Checks the disk usage for the system.
It uses df -h to get disk usage information. This example uses the path C:/Program Files/Git, so ensure this is correct for your system. Adjust the grep command if necessary.

create_snapshot():
Takes a snapshot of the files in the monitored directory and stores their MD5 hashes.
Saves the snapshot to a file for future comparison.

check_integrity():
Compares the current snapshot of the files against the previous one.
If changes are detected, it logs them and saves the new snapshot for future checks.

Main Execution Flow:
Starts by logging the initiation of the file integrity monitoring.
It runs a disk usage check and then checks file integrity by comparing current files with the previous snapshot.
If any changes are found, a warning is logged.
Finally, it creates a new snapshot of the directory's files to be used for future comparisons.

Steps to Use:
Set the directory path: Make sure to set the MONITOR_DIR variable to the correct directory path you wish to monitor.

Permissions: Ensure the script has the necessary permissions to read from the directory and write to the log and snapshot files.

Running the Script: Save the script as filemonitor.sh, then execute it in a terminal:

filemonitor.sh
Review Logs: Check the filemonitor.log for any changes or disk usage issues.

Example of Log Output:

Tue, Feb 08, 2025 02:30:00 PM: Starting file integrity monitoring...
Tue, Feb 08, 2025 02:30:10 PM: Disk space usage is under control. Current usage: 75%
Tue, Feb 08, 2025 02:30:15 PM: Snapshot created and saved.
Tue, Feb 08, 2025 02:30:20 PM: Integrity check complete. No changes detected.
Tue, Feb 08, 2025 02:30:30 PM: File integrity monitoring complete!
