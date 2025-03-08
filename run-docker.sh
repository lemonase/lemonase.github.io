#!/bin/bash

# build public site with hugo
docker run -v "$PWD:/src" hugomods/hugo:latest build 

# run nginx server with output html
docker rm blog-nginx
docker run --name blog-nginx --restart always -v './public:/usr/share/nginx/html:ro' -p 8008:80 -d nginx

