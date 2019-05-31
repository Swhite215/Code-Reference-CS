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

man # displays the command's manual
man command

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

clear # clears the screen

exit # exits the shell or your current session
