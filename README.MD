# Docker clean up notes
## show all container (hidden)
docker ps -a
docker images

# clean up docker images for more space
docker rmi -f $(docker images -a -q)

# clean up killed containers:
docker rm $(docker ps -a -f status=exited -f status=created -q)