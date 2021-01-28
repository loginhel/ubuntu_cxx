# ubuntu c++9开发环境

```
docker run -e TZ="Asia/Shanghai" --privileged -itd --net=clickhouse --ip="172.26.0.12" --name ubuntu-cxx -p 127.0.0.1:11022:22 -p 9011:9011  registry.cn-shenzhen.aliyuncs.com/hhp_dev/ubuntu_cxx:v0.1 /bin/bash

docker exec -it ubuntu-cxx /bin/bash

passwd root
vim /etc/ssh/sshd_config
	PasswordAuthentication yes
	PermitRootLogin yes
	UsePAM no
service ssh restart

暂时ubuntu的开发环境没法在旧版xshell中访问。折中办法：使用alpine的容器ssh登录跳转 ssh root@172.26.0.12
或者直接在windows下命令行可以访问：ssh root@127.0.0.1 -p 10022

apt list |grep ** 搜索
```