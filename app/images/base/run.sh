#!/bin/bash
sudo docker stop appbaseimage
sudo docker rm appbaseimage
sudo docker run --name appbaseimage -it -d registry.cn-hangzhou.aliyuncs.com/namespace/appbaseimage:latest