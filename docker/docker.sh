docker-compose -f docker-compose.yml down

docker-compose -f docker-compose.yml up -d \
container1 \
container2 \
containerN

docker exec -e ENVIRONMENT_VARIABLE=value container command [flags]

docker logs containerName
docker logs --tail 1000 containerName
docker cp file containerName:path
docker cp containerName:path file
docker cp -a folder containerName:path\
docker cp -a containerName:folder folder
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker version # returns version of client and server
docker info # returns configuration details
docker # returns list of commands
docker container run --publish 80:80 --name name -d nginx:version
docker container run --publish 80:80 --detach nginx # detach tells docker to run the container in the background
docker container ls # lists containers that are running
docker container ls -a # lists all containers
docker ps
docker ps -a
docker container stop containerId # stops the container
docker container run --publish 80:80 --detach --name name nginx
docker container logs containerName
docker container logs containerId
docker container top containerName
docker container top containerId
docker container --help
docker container rm multipleContainerId # must stop container before removing
docker top containerId # list all running processes running in container
docker top containerName
ps aux # show me all running processes
docker container start containerName # starts a stopped container
docker container start containerId
docker container run --publish 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=yes --name sqlDataBase -d mysql
docker container inspect containerName # details of one containers config
docker container inspect containerId
docker container stats containerName # performance statistics
docker container stats containerId
docker container run -it --name name image bash # starts container with interactive bash terminal, exit
docker container start -ai containerName # run an interative terminal from started container
docker container start -ai containerId
docker container exec -it containerName bash # run an interative bash terminal on a running container
docker container exec -it containerId bash
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' name
docker network ls # lists all networks created
docker network inspect networkName # lists details like containers attached to network
docker network create name # creates a network with default driver of bridge
docker container run -d --name name --network networkName image
docker network connect networkName
docker network connect networkId
docker network connect containerName
docker network connect containerId
docker network disconnect networkName
docker network disconnect networkId
docker network disconnect containerName
docker network disconnect containerId
docker pull imageName # pulls docker image to your computer
docker history imageName # shows image layers
docker image inspect imageName #returns meta data about the image
docker image tag imageName newImageName
docker image push imageName
docker inspect --format='{{.LogPath}}' containerName
docker login #logs into docker hub
docker logout #logs out from docker hub
docker image build -t customName . # builds docker image from file inside this directory
docker volume prune # removed unused volumes
docker container run -d --name name -v name:/path image # this creates a named volume with a path to the persisted data
docker volume create # creates a volume ahead of time
docker container run -d --name name -v /host/path/to/bind:/path/in/container #this creates container folder pointing to the host folder with access to contained files
docker-compose up # setup volumes/networks and start all containers
docker-compose down # stop all containers and remove cont/vol/net
docker image inspect image
docker swarm init
docker swarm join # joins a node to swarm                                                                                                                                                                                         - raft consensus database is created
docker node ls
docker service
docker service create image # creates services
docker service ls # lists services
docker service ps serviceName #shows tasks/containers in service
docker service update serviceName --replicas number
docker service update --secret-rm # removes secrets and redeploys container
docker stack
docker stack deploy -c composeFile stackName
docker secret
docker secret create name file # create a secret
docker secret ls # lists secrets
docker health