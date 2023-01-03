docker version # Version - Client and Server
docker info
docker # list of commands

docker run -d -p 8800:80 httpd # Run Basic Apache Server

docker ps # all container processes running

docker container run --publish 80:80 --name webhost --detach nginx
docker container ls
docker container stop containerID
docker container rm containerID
docker container logs containerID

docker run -d -p 80:80 --name nginx nginx # Run Basic Nginx Server
docker run -d -p 8080:80 --name apache httpd # Run Basic HTTPD Server
docker run -d -p 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=yes --name mysql mysql # Run Basic MySQL Server

docker container top container
docker container inspect container # details of one container config
docker container stats

docker container run -it # start new container interactively
docker container exec -it container /bin/bash # run additional processes
docker container start -ai container # restart container interactively