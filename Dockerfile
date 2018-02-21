FROM ubuntu:16.04
MAINTAINER Jeremy Nelson <jermnelson@gmail.com>, Jon Driscoll <jdriscoll@coloradocollege.edu>
ENV HOME /var/www/app
RUN apt-get update
RUN apt-get install -y apache2 apache2-dev git python-mysqldb
RUN apt-get install -y php7.0 php7.0-mysql php7.0-curl

# What's below follows the order of installation instructions at
# https://suma-project.github.io/Suma/installation/#suma-install-instructions
ADD Suma $HOME/Suma
RUN cd $HOME/Suma && \
    ln -s $HOME/Suma/web /var/www/html/suma/web && \
    ln -s $HOME/Suma/analysis /var/www/html/suma/analysis && \
    ln -s $HOME/Suma/service/web /var/www/html/sumaserver

COPY htaccess /var/www/html/sumaserver/.htaccess

COPY config/web-config.yaml $HOME/Suma/web/config/config.yaml

COPY config/server-config.yaml $HOME/Suma/config/config.yaml

COPY config/session.yaml $HOME/Suma/service/config/session.yaml

COPY config/spaceassessConfig.js $HOME/Suma/web/config/spaceassessConfig.js

COPY config/analysis-config.yaml /var/www/html/suma/analysis/config/config.yaml

# Note that a crontab can be set up at this point, following
# https://suma-project.github.io/Suma/installation/#suma-analysis-tools-configuration,
# to send nightly emails.

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
