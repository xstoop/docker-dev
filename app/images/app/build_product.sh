#!/bin/bash

# 登录阿里云docker repository
docker login --username=username --password=password --email=email registry.cn-hangzhou.aliyuncs.com

# 记录上一个版本
echo 'record the last previous version use tag older ..'
sudo docker tag registry.cn-hangzhou.aliyuncs.com/namespace/app:latest registry.cn-hangzhou.aliyuncs.com/namespace/app:older
sudo docker push registry.cn-hangzhou.aliyuncs.com/namespace/app:older

# 构建新版本:此时的上下文路径为当前目录
sudo docker build -f Dockerfile -t registry.cn-hangzhou.aliyuncs.com/namespace/app:latest ../../.

# 推送镜像
sudo docker push registry.cn-hangzhou.aliyuncs.com/namespace/app:latest