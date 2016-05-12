# PHP7 web app docker environment

Provide a full PHP7.0 - Nginx development environment using docker and docker-compose.

## Features

This docker-compose configuration provide a full development environment for PHP7 web app, including :

* PHP 7.0
* php7.0-fpm
* Nginx
* Git
* Composer
* Capistrano
* GruntJS and Gulp (managing assets)
* Mysql (client)
* PostgresSQL (client)
* Ssh (client)
* Ftp (client)

**You just need to fork this repo, clone your fork, edit 3 files with the name of your app and configure your git username and e-mail... you are ready to code !**

## Requirements
* Linux (As hosted OS or in a VM using Vagrant, for example):
  * ubuntu >= 14.04
  * fedora >= 21
  * debian >= 8.0
* docker >= 1.7
  * docker compose >= 1.3
* git
* acl


## Installation

**Docker**
Install docker and docker-compose using [the documentation](https://docs.docker.com/compose/install/) or [this script](https://gist.github.com/seblegall/13a663ff73c718b4a58a4cc454fc786c)

**Fork**
Fork this repo in order to update some config file and commit your change in your own repo.

**Configuration**
To get your full PHP7.0 development environment :

1. Edit the `docker-compose.yml` file and update the local domain name you want to use in the `web` section :
    ```yml
    extra_hosts:
        - "www.my-php-app.local:127.0.0.1"
    ```
2. Edit the `nginx/docker-entrypoint.sh` file and update the local domain name you want to use :
    ```sh
    echo "${WEB_PORT_80_TCP_ADDR}    www.my-php-app.local" >> /etc/hosts
    ```
3. Edit the `nginx/sites-available/my-php-app` file. Rename it with as you wish.

4. Edit the `docker-compose.yml` file with the name you give to your Nginx vhost.
    ```yml
    environment:
        NGINX_ENABLED_VHOST: my-php-app
    ```
5. Edit your Nginx vhost located in the `nginx/sites-available` directory and update the local domain name you want to use :
    ```sh
    server_name www.my-php-app.local www.my-php-app.localhost;

    root /srv/apps/my-php-app;
    index app.php

    access_log /var/log/nginx/my-php-app.access.log;
    error_log /var/log/nginx/my-php-app.error.log;
    ```
6. Add ACLs on the `apps` directory in order to be able to modify your files while docker is running.
    ```sh
    # Sous linux
    sudo setfacl -R -m u:"$(whoami)":rwX volumes/apps && sudo setfacl -R -dm u:"$(whoami)":rwX volumes/apps
    ```

7. Create your project directory under the `volumes/apps/` directory and create your first php file. (e.g. app.php)

8. Edit the `gitconfig` and set your git username and e-mail.

9. Run the containers :
    ```sh
    make install
    make up
    ```
10. Add this line to your `/etc/hosts` file : `127.0.0.1   www.my-php-app.local` (Updated with your local domain name)

11. Enjoy your app at http://www.my-php-app.local


## Usage

### Build the containers

```sh
make install
```

### Run the containers

```sh
make up
```

### Stop the containers

```sh
make stop
```

### CLI usage

If you need to launch some command inside the containers such as PHP cli tools, deploying (via Capistrano) or even commit your change, you can exec a bash shell inside the php-cli-docker container.

```sh
docker exec -it php_app_cli /bin/bash
```
Or, easier way, just launch this script :

```sh
# launch bash
./run_cli.sh
# launch any command
./run_cli.sh pwd
```
