## Deprecated

PLease use: https://github.com/beam-australia/laravel-docker

No longer maintained.

# laravel-hhvm-docker

A super fast, production hardened HHVM / PHP-7 `Dockerfile` served by Nginx forward proxy. See [link](http://goo.gl/Adqu0i) for the why. Perfect for horizontally distributed `Laravel` applications run within a Docker container cluster.

**Note** due to issues with Boot2Docker and VirtualBox response times on a local environment (with these tools) is slightly degraded with local volumes enabled.

**Note** Installs [hirak/prestissimo](https://github.com/hirak/prestissimo) composer parallel install plugin. If you have issues with composer installs remove this plugin.

## Stack

* **HHVM** (Facebooks PHP-7 runtime)
* **Nginx** (FastCGI web-server)
* **Composer** (PHP package manager)
* **PHPUnit** (PHP unit testing)

## Usage

Preferably used in a horizontally scaled Docker container environment (such as docker-compose) run alongside other services such as Redis and MariaDB.

CD into your cloned repository

````Bash
cd nginx-hhvm-docker
````

Firstly lets scale the `web` servers, from your project execute:

````Bash
docker-compose scale web=3
````

Now we boot the rest of the services by executing:

````Bash
docker-compose up
````

Voila! simply visit `nginx-hhvm.app` and you have a fully load-balanced, horizintally scaled application inferstructure!

**NOTE:** Make sure you add `nginx-hhvm.app` to your hosts file if developing locally with the IP address of the `docker-machine` instance.

## Configuration

We reccomend you create your own Dockerfile build, based upon this image.

Image is based upon the official nginx docker repository, see [git repo](https://github.com/nginxinc/docker-nginx) for more information.
