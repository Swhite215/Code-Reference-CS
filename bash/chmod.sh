# Example CHMOD Commands, a tool for modifying permissions

# Symbols
chmod u=rwx,g=rwx,o=rwx myFile # All groups all permissions
chmod u-rwx,g+rwx,o=rwx myFile # User remove all permissions, group add all permissions, other set all permissions

# Octal Numbers
# User = 7, 4 (read) + 2 (write) + 1 (execute)
# Group = 5, 4 (read) + 1 (execute)
# Other = 4, 4 (read)
chmod 754 myFile

chmod 777 myFile # All groups all permissions
chmod 444 myFile # All groups only read permissions
chmod 111 myFile # All groups only execute permissions
chmod 555 myFile # All groups read and execute permissions
chmod 333 myFile # All groups write and execute permissions
chmod 000 myFIle # All groups no permissions
