docker-compose -f docker-compose.yml down

docker-compose -f docker-compose.yml up -d \
container1 \
container2 \
containerN

docker exec -e ENVIRONMENT_VARIABLE=value container command [flags]
