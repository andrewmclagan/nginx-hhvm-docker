# laravel-hhvm-docker

A super fast, production hardened `Dockerfile` for Laravel [5.2.x] with incredible response times. See [link](http://goo.gl/Adqu0i) for the why. Perfect for horizontally distributed `Laravel` applications run within a Docker container cluster.

**Note** due to issues with Boot2Docker and VirtualBox response times on a local environment (with these tools) is slightly degraded with local volumes enabled.

## Stack

* **HHVM** (Facebooks PHP-7 runtime)
* **Nginx** (FastCGI web-server)
* **Composer** (PHP package manager)
* **PHPUnit** (PHP unit testing)

## Usage

Preferably used in a horizontally scaled Docker container environment (such as docker-compose) run alongside other services such as Redis and MariaDB.

#### Docker

To create the base image `andrewmclagan/laravel-hhvm-docker`, execute the following command within the folder:

````Bash
docker build -t andrewmclagan/laravel-hhvm-docker ./
````

Start your image binding the external ports 80 in all interfaces to your container:

````Bash
docker run -d -p 80:80 andrewmclagan/laravel-hhvm-docker
````

Test your deployment:

````Bash
curl http://localhost/
````

#### Docker Compose

Below is an example running Laravel in a distributed environment:

````YAML
load_balancer:
    image: tutum/haproxy
    links:
        - web
    ports:
        - "80:80"   
        - "443:443"    

cache:
    image: bitnami/redis
    ports:
        - "6379:6379"        

database:
    image: bitnami/mariadb
    environment:
        - MARIADB_DATABASE=laravel 
        - MARIADB_PASSWORD=SecretPassword123
    ports:
        - "3306:3306"         

web:
    image: andrewmclagan/laravel-hhvm-docker
    volumes:
        - ./path/to/laravel:/var/www
    links:
        - database
        - cache
    environment:
        - APP_ENV=production
        - DB_DATABASE=laravel          
        - DB_PASSWORD=SecretPassword123  
        - VIRTUAL_HOST=laravel.local

````

Firstly lets scale the `web` servers, from your project execute:

````Bash
docker-compose scale web=3
````

Now we boot the rest of the services by executing:

````Bash
docker-compose up
````

Voila! simply visit `laravel.local` and you have a fully load-balanced, horizintally scaled application inferstructure!

**NOTE:** Make sure you add `laravel.local` to your hosts file if developing locally with the IP address of the `docker-machine` instance.

## Configuration

To customize any of the settings for application files, `HHVM`, `PHP`, `Nginx` or `Systemd` the following environment variables are available: 

* **APP_PATH** path to your application files, default: `./`

* **CONFIG_SUPERVISORD** supervisord config file, default: `./config/supervisord.conf`

* **CONFIG_PHP** php.ini or HHVM.ini settings, default: `./config/php.ini`

* **CONFIG_NGINX** nginx config file, default: `./config/nginx.conf`

* **CONFIG_ENTRY** docker entrypoint script, default: `./docker-entrypoint.sh`
