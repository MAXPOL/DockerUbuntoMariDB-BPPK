
#!/bin/bash
docker start DOCKER_CONTAINER_NAME
docker exec DOCKER_CONTAINER_NAME service mysql start
docker exec DOCKER_CONTAINER_NAME service apache2 start
