FROM atdocker/debian:latest

RUN mkdir -p /opt/nginx/source; \
    cd /opt/nginx/source; \
    wget http://nginx.org/download/nginx-1.7.10.tar.gz; \
    tar zxf nginx-1.7.10.tar.gz; \
    rm nginx-1.7.10.tar.gz; \
    mv nginx-1.7.10 nginx; \
    mkdir /opt/nginx/source/modules; \
    cd /opt/nginx/source/modules; \
    wget https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz; \
    tar zxf 2.3.tar.gz; \
    wget https://github.com/masterzen/nginx-upload-progress-module/archive/v0.9.1.tar.gz; \
    tar zxf v0.9.1.tar.gz; \
    rm *.gz; \
    cd /opt/nginx/source/nginx; \
    ./configure \
      --prefix=/usr \
      --add-module=/opt/nginx/source/modules/ngx_cache_purge-2.3 \
      --add-module=/opt/nginx/source/modules/nginx-upload-progress-module-0.9.1 \
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
    make && make install; \
    chmod a+x /etc/init.d/nginx; \
    mkdir /var/www; \
    chown www-data:www-data -Rf /var/www; \
    rm -rf /opt/nginx/source/; \
    chmod a+x /etc/init.d/nginx; \
    mkdir -p /var/lib/nginx/speed; \
    mkdir -p /etc/nginx/includes; \
    mkdir -p /etc/nginx/sites-available; \
    mkdir -p /etc/nginx/sites-enabled;

ADD  ./etc/init.d/nginx        /etc/init.d/nginx
COPY ./etc/nginx/nginx.conf    /etc/nginx/nginx.conf
COPY ./etc/nginx/conf.d/*      /etc/nginx/conf.d/
COPY ./etc/nginx/includes/*    /etc/nginx/includes/
COPY ./etc/supervisor/conf.d/* /etc/supervisor/conf.d/

EXPOSE 80 443
CMD exec supervisord -n
