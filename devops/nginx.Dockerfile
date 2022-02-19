FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY devops/nginx.conf /etc/nginx/conf.d/default.conf
RUN cat /etc/nginx/conf.d/default.conf