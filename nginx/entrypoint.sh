#!/usr/bin/env bash

cp /etc/apt/sources.list /etc/apt/sources.list.orig
sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
sed -i s@/security.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
apt-get clean && apt-get update

alias ll="ls -al"

ngx_ver=`nginx -v 2>&1|awk -F/ '{print $2}'|awk -F. '{print $1 "." $2 "." $3}'`

if [ -z "$ngx_ver" ]; then
  echo "ngx_ver not found"
  exit 11
fi

apt-get -y install build-essential make automake libtool autoconf wget git gcc libpcre3-dev libssl-dev zlib1g-dev

cd /tmp && mkdir -p nginx-installer
cd nginx-installer

exit_if_error() {
  [ $1 != 0 ] && {
    [ ! -z $2 ] && echo $2
    exit 10
  }
}

wget -c https://nginx.org/download/nginx-${ngx_ver}.tar.gz
exit_if_error $? "nginx tar download error"



git clone https://github.com/vkholodkov/nginx-upload-module.git
git clone https://github.com/openresty/echo-nginx-module.git
git clone https://github.com/masterzen/nginx-upload-progress-module.git
tar xf nginx-${ngx_ver}.tar.gz
cd nginx-${ngx_ver}

./configure  --with-compat --add-dynamic-module=../nginx-upload-progress-module --add-dynamic-module=../nginx-upload-module --add-dynamic-module=../echo-nginx-module
#-prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp
make modules
cp objs/ngx_http_upload_module.so /usr/lib/nginx/modules/
cp objs/ngx_http_echo_module.so /usr/lib/nginx/modules/
cp objs/ngx_http_uploadprogress_module.so /usr/lib/nginx/modules/


nginx -g 'daemon off;'