#!/bin/bash

sudo docker stop app

sudo docker rm app

sudo docker run --name app -it -d -p 8003:80 registry.cn-hangzhou.aliyuncs.com/namespace/app:test