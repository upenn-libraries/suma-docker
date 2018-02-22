# Dockerized Suma

## Docker Environment

## Configuration

1. In the `config` directory:
	1. Copy `analysis-config_TEMPALTE.yaml` to `analysis-config.yaml`.
	2. Copy `mysql_TEMPLATE.env` to `mysql.env`.
	3. Copy `server-config_TEMPALTE.yaml` to `server-config.yaml`.
	4. Open the three files you created in the steps above (`analysis-config.yaml`, `mysql.env`, and `server-config.yaml`) and modify them as appropriate (generating new passwords, etc.).
2. From the main directory of this repository, run `docker-compose up`, or, if you'd like to re-build the images, `docker-compose up --build`.

## License

The code in this repository is released under the MIT License.

## Links
*   [Suma Github Repository](https://github.com/suma-project/Suma)
*   [Suma Documentation](https://suma-project.github.io/Suma/)
