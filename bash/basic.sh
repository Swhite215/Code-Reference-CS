# Basic Linux Commands

cat # concatenates and displays files
cat filename

cd # changes the current directory
cd path/to/directory/file

clear # clears the screen

command --help
command -h

cp # copy
cp -r source_directory destination
cp source_file destination_file
cp source_file1 source_filen dest_dir

date #displays the date - Thu Aug 22 10:07:32 EDT 2019
date -R # - Thu Aug 22 10:07:32 EDT 2019
date -r filename
date -u # - Thu Aug 22 14:08:34 UTC 2019
date "+DATE: %Y-%m-%d" # - DATE: 2019-08-22
date "+TIME: %H:%M:%S" # - TIME: 10:10:45

du # disk usage of all files in current directory
du file

echo "string"
echo # displays arguments to the screen
echo $ENVIRONMENT_VARIABLE
echo $PATH # displays command search directories and order

exit # exits the shell or your current session

export # set environment variable
export VAR="value"

groups # displays groups user is a part of

gunzip file

gzip # compressing files to save space
gzip file

ifconfig # configures and shows network interface parameters
ifconfig -a

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

sort # sort a files content
sort -r file
sort -u file
sort file

su # switch to user
su [username]

sudo # super user do, install, start, and stop applications requiring higher access
sudo -l # list commands
sudo -u root command # run command as super user
sudo -u user command # run command as another user
sudo command # run command as super user
sudo su # switch to super user

tree # displays tree structure
tree -C #display in color
tree -d # displays only directories

unset VAR # unsets environment variable

which # shows location or full path to the command that you're executing
which ls
which node
which npm

whoami # shows what user you are
