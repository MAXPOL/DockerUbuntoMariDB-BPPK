
#!/bin/bash
docker exec DOCKER_CONTAINER_NAME service mysql start
docker exec DOCKER_CONTAINER_NAME service apache2 start
