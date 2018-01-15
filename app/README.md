## app build说明

### 注意

以下说明中运行命令如果报错，请先使用dos2unix命令将脚本中在windows下编辑产生的`^M`字符去掉。
```
dos2unix run.sh
```

### images/base目录

images/base构建项目基础镜像的目录。

基础镜像基于[phusion/baseimage:0.9.19](https://github.com/phusion/images/base-docker)ubuntu镜像，并集成nginx+php-fpm，无数据库。
在phusion/baseimage的基础上，做了一些配置：

* 关闭了SSH功能
* 关闭了计划任务cron
* 关闭了vim的兼容模式
* 设置时区为PRC

构建的镜像将会自动推送到阿里云镜像仓库:`registry.cn-hangzhou.aliyuncs.com/namespace/app:latest`

#### 目录结构说明

```
./images/base 
./images/base/etc/        基础镜像中ubuntu系统的一些自定义配置文件
./images/base/nginx/      基础镜像中nginx的配置文件
./images/base/php-fpm     基础镜像中php-fpm的配置文件
./images/base/bulid.sh    构建基础镜像docker shell脚本
./images/base/Dockerfile  基础镜像Dockerfile
./images/base/run.sh      运行一个使用基础镜像的容器
```

#### 构建镜像

进入`images/base`目录，运行命令：
```
sudo ./build.sh
```
build.sh脚本会执行docker的构建命令，构建完成后会登录阿里云镜像仓库并推送镜像到appbaseimage:latest。

#### 运行容器

进入`images/base`目录，运行命令：
```
sudo ./run.sh
```
run.sh脚本会启动一个使用appbaseimage:latest镜像，名为`appbaseimage`的容器，运行后可以使用`docker exec -it appbaseimage bash`验证容器的状态。

#### nginx

nginx默认配置了一个虚拟主机/etc/nginx/virtual-hosts/status，可在容器内通过

```
curl 127.0.0.1:8001/nginxstatus
curl 127.0.0.1:8001/phpstatus?full
```
查看nginx状态与php-fpm的工作状态。

nginx基本未做什么其他优化配置，基本都采用默认的配置。

#### php-fpm

php-fpm版本为7.0，除默认扩展外，只安装有php7.0-curl扩展。

php-fpm采用ondemand模式管理子进程，最大子进程100，默认开启慢日志(超过60秒)请求日志记录。

### images/app目录

该目录主要是构建app项目镜像的一些文件与脚本。

app基于appbaseimage:latest镜像进行构建，在appbaseimage:latest镜像中添加nginx 本项目的虚拟主机配置、复制本项目的文件到nginx的工作目录/var/www/html/app/。

此外，该镜像的构建没有安装项目的依赖，只是简单的将项目文件拷贝进基础镜像中，因此在构建该镜像前需要自行使用composer来完成项目依赖的安装。

构建的镜像将会自动推送到阿里云镜像仓库:registry.cn-hangzhou.aliyuncs.com/namespace/app。

#### 目录说明

```
./images/app
./images/app/nginx                icproxy镜像的nginx虚拟主机配置
./images/app/build_product.sh     构建生产环境的icproxy镜像，使用latest标签
./images/app/build_test.sh        构建测试环境的icproxy镜像，使用test标签
./images/app/Dockerfile           镜像构建脚本
./images/app/run_product.sh       运行一个使用latest标签的镜像容器
./images/app/run_rest.sh          运行一个使用test标签的镜像容器
```

#### 构建镜像

进入`images/app`目录，运行命令：

```
# 构建生产环境的app镜像
sudo ./build_product.sh
# 或者运行 构建测试环境的app镜像
sudo ./build_test.sh
```

#### 运行镜像

进入`images/app`目录，运行命令：
```
# 运行生成环境容器
sudo ./run_product.sh
# 运行测试环境容器
sudo ./run_test.sh
```