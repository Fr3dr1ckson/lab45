FROM nginx:alpine

# Remove the default config to avoid conflict
RUN rm /etc/nginx/conf.d/default.conf

# Copy app files
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Copy custom nginx config
COPY default.conf /etc/nginx/conf.d/default.conf
