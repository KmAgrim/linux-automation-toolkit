Linux Automation Toolkit

Scripts

system_info.sh
    Menu driven system information utility.

backup_script.sh
    Creates compressed timestamped backups.

file_report.sh
    Reports information about files and directories.

archive_old_files.sh
	Creates Compressed timestamped archives of files that are older than the specified date.

cleanup_logs.sh 
    Removes .log files older than the specified number of days using file modification time (mtime).

disk_usage_report.sh
    Generates Disk Usage for a given Directory and show Largest 10 Directories and Files.

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
