# Attendance Tracker Project Bootstrapper

## How to run
1. Make the script executable: `chmod +x setup_project.sh`
2. Run it: `./setup_project.sh`
3. Enter a project name when prompted — this creates `attendance_tracker_<name>/`
4. Choose whether to update attendance thresholds (y/n)
5. If yes, enter numeric Warning and Failure values — these update Helpers/config.json via sed
6. The script checks if python3 is installed and reports the result

## Triggering the archive (interrupt) feature
While the script is running, press Ctrl+C at any point.
This triggers a trap that:
- Compresses the current project folder into `attendance_tracker_<name>_archive.tar.gz`
- Deletes the incomplete `attendance_tracker_<name>/` folder
