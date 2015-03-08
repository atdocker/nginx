nginx
====

Nginx 1.7.10 with some some more modules:

- ngx_cache_purge v2.3
- nginx-upload-progress-module v0.9.1

## Usage

    # hosting some simple static content
    docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro atdocker/nginx:latest
    
    # exposing the port
    docker run --name some-nginx -d -p 8080:80 some-content-nginx
