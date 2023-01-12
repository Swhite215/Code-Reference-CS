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

docker container port container
docker container inspect --format "{{ .NetworkSettings.IPAddress }}" container

docker network ls
docker network inspect
docker network create --drive
docker network connect

docker image history
docker image tag <image> <tag>
docker image push <image-tag>
docker image build -t customnginx -f Dockerfile

docker login
docker logout

dockver volume inspect container

docker compose up
docker compose up --build
docker compose down
docker compose ps
docker compose top
docker compose build

docker swarm init
docker swarm --help
docker node ls
docker service create alpine ping 8.8.8.8
docker service update sbrtbt4vnxbu --replicas 3
docker update

docker container run -d -p 5000:5000 --name registry registry
docker pull hello-world
docker tag hello-world 127.0.0.1:5000/hello-world
docker image ls
docker push 127.0.0.1:5000/hello-world
docker container rm 127.0.0.1:5000/hello-world
docker pull 127.0.0.1:5000/hello-world

docker container run -d -p 5000:5000 --name registry -v $(pwd)/registry-data:/var/lib/registry registry
