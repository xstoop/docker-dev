## app镜像打包Dockerfile说明

采用[phusion/baseimage](https://github.com/phusion/baseimage-docker):0.9.19作为基础ubuntu镜像，集成nginx+php-fpm+app，无数据库

在phusion/baseimage的基础上，做了一些配置：
* 关闭了SSH功能
* 关闭了计划任务cron
* 设置了vim的兼容模式
* 设置时区为PRC

### 运行

运行build.sh构建镜像。运行run.sh启动一个容器并监听8003端口。脚本不会自动完成composer项目依赖。在构建前请自行完成项目依赖安装

### nginx

构建前需要重新配置nginx虚拟主机，见nginx/sites-available与nginx/sites-enabled目录

容器内部查看nginx状态：curl 127.0.0.1:8001/nginxstatus

### php-fpm

php-fpm版本为7.0

php-fpm采用ondemand模式管理子进程，最大子进程100，默认开启慢日志请求日志记录

容器内部查看php-fpm状态：curl 127.0.0.1:8001/phpstatus?full
