#!/bin/bash

# 构建镜像:此时的上下文路径为当前目录
sudo docker build -f Dockerfile -t registry.cn-hangzhou.aliyuncs.com/namespace/app:test ../../.

#登录阿里云docker repository
docker login --username=username --password=password --mail=mail registry.cn-hangzhou.aliyuncs.com

#推送镜像
sudo docker push registry.cn-hangzhou.aliyuncs.com/namespace/app:test