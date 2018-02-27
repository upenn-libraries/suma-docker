# Dockerized Suma

This repository bundles [Suma](https://github.com/suma-project/Suma), a webapp for facilitating performing head-counts in libraries, in a network of Docker containers, allowing it to be deployed with a single command (`docker-compose up`).

Suma's documentation can be found [here](https://suma-project.github.io/Suma/).

## Docker Environment

The files in this repository use `docker-compose` version 3+. See [here](https://docs.docker.com/compose/install/) for installation instructions for `docker-compose` and its dependencies (including `docker`).

## Configuration

1. Clone this repository along with its `Suma` submodule with `git clone --recurse-submodules https://github.com/USERNAME/suma-docker` (where `USERNAME`) is replaced to match whatever fork of this repository you're using.
1. This Docker repository requires one minor change to be made to Suma itself, for the `zend` dependency that ships with it to work:  
   In `service/web/index.php`, replace  
	   ```php
	   ini_set('include_path', ini_get('include_path') . PATH_SEPARATOR . $SUMA_SERVER_PATH . PATH_SEPARATOR . $SUMA_SERVER_PATH . '/lib/zend/library');
       ```
       with
	   ```php
	   ini_set('include_path', ini_get('include_path') . PATH_SEPARATOR . $SUMA_SERVER_PATH . '/service' . PATH_SEPARATOR . $SUMA_SERVER_PATH . '/service/lib/zend/library');
   	   ```
1. In the `config` directory:
	1. Copy `analysis-config_TEMPALTE.yaml` to `analysis-config.yaml`.
	2. Copy `mysql_TEMPLATE.env` to `mysql.env`.
	3. Copy `server-config_TEMPALTE.yaml` to `server-config.yaml`.
	4. Open the three files you created in the steps above (`analysis-config.yaml`, `mysql.env`, and `server-config.yaml`) and modify them as appropriate (generating new passwords, etc.).
1. From the main directory of this repository, run `docker-compose up`, or, if you'd like to re-build the images, `docker-compose up --build`. If you would like to run the containers detached from the current shell, you can add `-d`: `docker-compose up -d`.  
1. To stop the container:
    1. If attached, you can use `Ctrl+C`.
    2. If detached, you can use `docker-compose down`.  
	   Volume data should persist across times you bring the containers up or down. If you would like to wipe the container data, you can use `docker-compose down --volumes`.
1. To get a shell with the html container, you can use `docker exec -i -t suma_web /bin/bash`.
1. To back up container data (e.g., from the `MySQL` container), you can use (while the `suma_mysql` container is running)  
```sh
source config/mysql.env
docker exec suma_mysql mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > backup.sql 2>backup_errors
```
1. Similarly, container data can be restored with the following (while the `suma_mysql` container is running):  
```sh
source config/mysql.env
cat backup.sql | docker exec -i suma_mysql /usr/bin/mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE
```
1. To access Suma:
	1. The Administration interface is at http://localhost/sumaserver/admin/login.  
	   The login credentials are set in `config/server-config.yaml` in the `admin` section.
	1. The data entry interface is at http://localhost/suma/web.
	1. The analytics interface is at http://localhost/suma/analysis/reports/.

## License

The code in this repository is released under the [MIT License](LICENSE.md).
