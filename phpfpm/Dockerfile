FROM seblegall/php-docker:7.0
MAINTAINER Sébastien Le Gall <seb@le-gall.net>

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

RUN mkdir -p /run/php

RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
                    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
                    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
	            && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
	            && echo "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707" > /etc/php/7.0/fpm/conf.d/blackfire.ini

VOLUME /srv/apps
WORKDIR /srv/apps

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.0", "-F"]
