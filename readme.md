# docker-compose 构建lnmp开发环境

```shell script


git clone https://github.com/strever/lnmp.git
cd lnmp       
cd php/demo-app
composer install
cd ..
docker-compose up -d 
cd nginx
chmod +x gen_cert.sh
./gen_cert.sh
cd ..

```



# links

- https://www.nginx.com/resources/wiki/start/topics/examples/full/
- http://download.redis.io/redis-stable/redis.conf


--character-set-server=utf8