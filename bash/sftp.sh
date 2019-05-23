# Example SFTP Commands, SSH File Transfer Protocol, a secure file transfer protocol

sftp host # Connect to host -> Run Commands

sftp ilab@19.86.108.22 <<END
  # Multiple Commands
  help # Get List of Commands
  
  mkdir test
  put -r path/to/directory
  put path/to/file
  
  # Remove a directory with scp, easier...
END
