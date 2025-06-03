FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf


CMD ["nginx", "-g", "daemon off;"]
