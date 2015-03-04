FROM atdocker/debian:latest
ADD ect/init.d/nginx /etc/init.d/nginx
RUN mkdir -p /root/source/nginx; \
    cd /root/source/nginx; \
    wget wget http://nginx.org/download/nginx-1.7.10.tar.gz; \
    tar zxf nginx-1.7.10.tar.gz; \
    mkdir -p /root/source/nginx/modules; \
    cd /root/source/nginx/modules; \
    wget wget https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz; \
    tar zxf 2.3.tar.gz; \
    cd /root/source/nginx/nginx-1.7.10;
    ./configure \
      --prefix=/usr \
      --add-module=/root/source/nginx/modules/ngx_cache_purge-2.3/ \
      --with-http_addition_module \
      --with-http_auth_request_module \
      --with-http_dav_module \
      --with-http_degradation_module \
      --with-http_flv_module \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_mp4_module \
      --with-http_random_index_module \
      --with-http_realip_module \
      --with-http_spdy_module \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --without-mail_pop3_module \
      --without-mail_imap_module \
      --without-mail_smtp_module \
      --without-http_scgi_module \
      --without-http_uwsgi_module \
      --with-ipv6 \
      --with-debug \
      --user=www-data \
      --group=www-data \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/var/log/nginx/error.log \
      --http-log-path=/var/log/nginx/access.log \
      --sbin-path=/usr/sbin/nginx \
      --lock-path=/var/lock/nginx.lock \
      --pid-path=/var/run/nginx.pid; \
    chmod a+x /etc/init.d/nginx; \
    mkdir /var/www; \
    chown www-data:www-data -Rf /var/www; \
    rm -rf /root/source/; \
