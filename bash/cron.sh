# Example CRON Commands, a tool for scheduling jobs

crontab file # adds job to crontab
crontab -l # list cron jobs
crontab -e # edit your cron jobs
crontab -r # remove all of your cron jobs

# cron file example

# Run every minute
# * * * * * path/to/job

# @yearly path/to/job - 0 0 1 1 *
# @annually path/to/job - 0 0 1 1 *
# @monthly  path/to/job - 0 0 1 * *
# @weekly path/to/job - 0 0 * * 0
# @daily path/to/job - 0 0 * * *
# @midnight path/to/job - 0 0 * * *
# @hourly path/to/job - 0 * * * *

# Minute Hour DayOfMonth MonthOfYear DayOfWeek or * * * * *
# Minute 0 - 59
# Hour 0 - 23
# DayOfMonth 1 - 31
# MonthOfYear 1 - 12
# DayOfTheWeek 0 - 6 (0 is Sunday)
