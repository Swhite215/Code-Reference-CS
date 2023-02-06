# List Docker Images
docker image ls

# Build Docker Container from DockerFile
docker build -t webapp .

# Run Docker Container
docker run -d -p 8080:80 --name myapp webapp

# Check Docker Container is Running
docker ps -a