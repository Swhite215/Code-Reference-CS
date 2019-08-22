# Basic Linux Commands

apropos command # same as man -k keyword

cat # concatenates and displays files
cat filename

cd # changes the current directory
cd path/to/directory/file

clear # clears the screen

command --help
command -h

command; command; command # multiple commands chained together

command | sort | less # sort and analyze output from command
command | sort | uniq | less # sort and anaylze unique output from command
command | tee file | less 

cp # copy
cp -r source_directory destination
cp source_file destination_file
cp source_file1 source_filen dest_dir

du # disk usage of all files in current directory
du file

echo "string"
echo # displays arguments to the screen
echo $ENVIRONMENT_VARIABLE
echo $PATH # displays command search directories and order
echo {A...Z} # brace expansion
echo {0...N}

exit # exits the shell or your current session

export # set environment variable
export VAR="value"

groups # displays groups user is a part of

ifconfig # configures and shows network interface parameters
ifconfig -a

info program # displays info documents for program or command
info coreutils

ls # lists directory contents
ls -F # reveals file types, /Directory, @Link, *Executable
ls -al # shows hidden files
ls -l # permissions, number of links, owner, group, bytes, last modification time, file/directory name
ls -r # lists files in reverse order
ls -t # lists files by time
ls /bin

man # displays the command's manual
man -k keyword # finds commands associated with keyword
man command

mkdir # creates a directory
mkdir -p
mkdir duplicates/dir-{001-100} # brace expansion

mv # move or rename
mv firstName newName
mv folder/* /path/to/newFolder # moves all files in a folder to a new folder
mv source destination

printenv # displays all environment variables
printenv # displays evnironment variables
printenv variable # displays specific environment variable

pwd # displays the present working director

rm - rf directory
rm -f file
rm -r dir
rm file

rmdir # removes a directory
rmdir -p

script file # makes a typescript of everything printed on your terminal

sort # sort a files content
sort -r file
sort -u file
sort file

source ~/.bashrc # reloads the .bashrc file

stat file # displays information about the file

su # switch to user
su [username]

sudo # super user do, install, start, and stop applications requiring higher access
sudo -l # list commands
sudo -u root command # run command as super user
sudo -u user command # run command as another user
sudo command # run command as super user
sudo su # switch to super user

touch file # creates a file
touch duplicates/dir-{001-100}/file-{A...Z} # brace expansion

tree # displays tree structure
tree -C #display in color
tree -d # displays only directories

unset VAR # unsets environment variable

wc file # displays the number of lines, words, and bytes in the file

which # shows location or full path to the command that you're executing
which ls
which node
which npm

whoami # shows what user you are
