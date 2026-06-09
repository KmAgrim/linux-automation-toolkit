Linux Automation Toolkit

Scripts

system_info.sh
    Menu-driven system information utility.

backup_script.sh
    Creates compressed timestamped backups.

file_report.sh
    Reports information about files and directories.

archive_old_files.sh
    Creates compressed timestamped archives containing files older than the specified number of days.

cleanup_logs.sh
    Removes .log files older than the specified number of days using modification time (mtime).

disk_usage_report.sh
    Generates a disk usage report for a directory and displays the 10 largest files and directories.

process_info.sh
    Displays information about processes matching a given process name.

network_info.sh
    Displays network information based on user selection or command-line argument.

Requirements

Linux
Bash

Usage Examples

./backup_script.sh source_dir backup_dir

./file_report.sh dir1 dir2 file1

./system_info.sh

./archive_old_files.sh source_dir archive_dir days

./cleanup_logs.sh log_directory days

./disk_usage_report.sh some_directory

./process_info.sh process_name

./network_info.sh [OPTION]
