# Example Process Commands, tools for seeing and killing processes

ps # displays processes
ps -e # displays all processes
ps -f # format listing
ps -p pid # displays specific process

top # displays processes, ordered by cpu resources
htop # displays processes

kill # kills a process
kill -l # displays a list of signals
kill pid # kills a process
kill -TERM pid # kills a process
kill -15 pid # kills a process

command & # run a process in the background
