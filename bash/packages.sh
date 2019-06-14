# Example package Commands, tools for downloading, updating and removing packages

# RPM Package Managers
yum # installs packages
yum search string
yum info [package]
yum install [-y] package
yum remove package

rpm # installs packages, Redhat Package Manager
rpm -qa # list all installed packages
rpm -qf /path/to/file # list the files package
rpm -ql package # list package's files
rpm -ivh package.rpm # install package
rpm -e package # removes a package

# DEB Package Managers
apt # advanced packing tool
apt-cache search string #  search for string
apt-get install -y package #  install a package
apt-get remove package #  remove package
apt-get purge package #  remove package and metadata
apt-cache show package #  show package

dpkg #  debian package
dpkg -l #  list installed Packages
depkg -S /path/to/file #  list file's package
dpkg -L #  list all files in package
depkg -i .deb file # install package
