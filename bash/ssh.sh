# Example SSH Commands, Secure Shell, provides a secure encrypted connection between two hosts over an insecure network

ssh remoteComputer # Enter Username and Password
ssh username@remoteComputer
ssh -l username remoteComputer

# Execute Commands on Host
ssh hostname command

# Special Commands
ssh-keygen # tool for creating new authentication key pairs for ssh, -t = algorithm, -b = key size
ssh-keygen -t [rsa, dsa, ecdsa, ed25519] -b [rsa: 2048, 4096] [ecdsa: 256, 384, 521]
ssh-keygen -f ~/path -t rsa -b 2048

ssh-copy-id # copy public key to server and installed in authorized_keys file
ssh-copy-id -i ~/path user@host

ssh-agent # helper program to implement single sign-on
eval `ssh-agent`, starts ssh-agent
echo $SSH_AGENT_SOCK,check if ssh-agent has been used

ssh-add # add default files to agent
ssh-add -l # lists private keys currently accessible to the agent

# Local Forwarding - Connect my local machine port to process running on server at port
ssh -L PORT:localhost:PORT USER@VM_IP

# Remote Forwarding - Connect my server port to process running on my local machine at port
ssh -R PORT:localhost:PORT USER@VM_IP

# Default Files ~/.ssh/id_rsa, .ssh/id_dsa, ~/.ssh/id_ecdsa,~/.ssh/ed25519, ~/.ssh/identity
