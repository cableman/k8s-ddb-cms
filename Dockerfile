FROM itkdev/php7.0-fpm
LABEL maintainer "ITK Dev <itkdev@mkb.aarhus.dk>"

# Move site into the container.
COPY htdocs /app

# Copy configuration.
COPY etc/ /etc/

EXPOSE 9000

WORKDIR /app

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD [ "docker-entrypoint.sh" ]