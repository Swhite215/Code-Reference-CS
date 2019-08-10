# Basic Linux Commands

ls # lists directory contents
ls -l # permissions, number of links, owner, group, bytes, last modification time, file/directory name
ls -al # shows hidden files
ls -F # reveals file types, /Directory, @Link, *Executable
ls -t # lists files by time
ls -r # lists files in reverse order
ls /bin

ifconfig # configures and shows network interface parameters
ifconfig -a

tree # displays tree structure
tree -d # displays only directories
tree -C #display in color

groups # displays groups user is a part of

cd # changes the current directory
cd path/to/directory/file

pwd # displays the present working director

cat # concatenates and displays files
cat filename

echo # displays arguments to the screen
echo $ENVIRONMENT_VARIABLE
echo "string"
echo $PATH # displays command search directories and order

export # set environment variable
export VAR="value"
unset VAR # unsets environment variable

VAR="value"
printenv # displays evnironment variables
printenv # displays all environment variables
printenv variable # displays specific environment variable

man # displays the command's manual
man command
man -k keyword # finds commands associated with keyword

which # shows location or full path to the command that you're executing
which node
which npm
which ls

command --help
command -h

mkdir # creates a directory
mkdir -p

rmdir # removes a directory
rmdir -p

rm - rf directory
rm file
rm -r dir
rm -f file

cp # copy
cp source_file destination_file
cp source_file1 source_filen dest_dir
cp -r source_directory destination

mv # move or rename
mv source destination
mv firstName newName
mv folder/* /path/to/newFolder # moves all files in a folder to a new folder

sort # sort a files content
sort file
sort -u file
sort -r file

du # disk usage of all files in current directory
du file

gzip # compressing files to save space
gzip file
gunzip file

su # switch to user
su [username]

sudo # super user do, install, start, and stop applications requiring higher access
sudo -l # list commands
sudo command # run command as super user
sudo -u root command # run command as super user
sudo -u user command # run command as another user
sudo su # switch to super user

whoami # shows what user you are


clear # clears the screen

exit # exits the shell or your current session
