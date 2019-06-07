# Example Input, Output, and Redirection

# > Redirects standard output to a file, overwrites
# >> Redirects standard output to a file, appends
# < Redirects input from a file to a command
# >/dev/null remove useless

ls > files.txt # writes ls result to files.txt
ls >> files.txt # appends ls result to files.txt
sort < files.txt # takes files.txt content and provides to sort command
sort < files.txt > sorted_files.txt #takes files.txt content, provides to sort command, and writes to sorted file

ls 1> files.txt # writes ls result to files.txt
ls 2> files.txt # writes ls error result to files.txt
ls files.txt filesTwo.txt 1>out 2>out.err # writes stdout to out and stderr to out.err
ls files.txt filesTwo.txt > out.both 2>&1 # writes stdout and stderr to out.both
