FROM debian:10

RUN apt-get update && apt-get install php php-fpm php-cli php-mysql bash curl php-pdo php-gd php-mstring -y

COPY ./script /script

RUN chmod +x /script.sh

RUN mkdir -p /run/php

CMD ["/script.sh"]
