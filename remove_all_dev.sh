#remove all containers
docker-compose -f devops/docker-compose.yml down
docker volume prune -y