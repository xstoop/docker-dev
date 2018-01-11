sudo docker stop project
sudo docker rm project
sudo docker run --detach --name project -it -d  -p 8003:80 project:latest
