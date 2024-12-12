FROM wordpress:latest
RUN apt-get update && apt-get install -y vim less nano
# Set the ServerName to avoid Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf