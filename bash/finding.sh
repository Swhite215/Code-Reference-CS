# Commands to Find Files or Directories

find [path] [expression] # finds a file or directory within the path

find . -name *.html # find all html files in directory
find . -name *.css # find all css files in directory
find . -name *.jpg # find all jpeg files in directory

find . -mtime +10 -mtime -13 # find files more than 10 days old but less than 13 days old in the current directory

find . -size +1M # find files more than 1MB in size

locate pattern # finds a file or directory within an index, not in real time
