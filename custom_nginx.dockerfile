FROM nginx:latest
RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir /var/www
