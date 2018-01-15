#!/bin/bash

#使用dockerfile构建基础镜像
docker build -f Dockerfile --tag appbaseimage:latest .

#登录阿里云docker repository
docker login --username=username --password=password --mail=mail registry.cn-hangzhou.aliyuncs.com

#推送镜像
sudo docker push registry.cn-hangzhou.aliyuncs.com/namespace/appbaseimage:latest