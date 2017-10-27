FROM ubuntu:16.04
MAINTAINER Jeremy Nelson <jermnelson@gmail.com>, Jon Driscoll <jdriscoll@coloradocollege.edu>
ENV HOME /var/www/app
RUN apt-get update && apt-get install -y apache2 apache2-dev git python-mysqldb libapache2-mod-php
RUN apt-get install -y php php-mcrypt php-mysql 

ADD Suma $HOME/Suma
RUN cd $HOME/Suma && \
    ln -s $HOME/Suma/service/web/ /var/www/html/sumaserver && \
    cd /var/www/html && mkdir suma && ln -s $HOME/Suma/web/ /var/www/html/suma/client && \
    ln -s $HOME/Suma/analysis/ /var/www/html/suma/analysis && \
    mkdir $HOME/Suma/sumalogs && chown www-data:www-data $HOME/Suma/sumalogs && \
    a2enmod rewrite

#RUN cd /var/www/html && mkdir suma && mkdir sumaserver && \
#    cd suma && mkdir web && mkdir analysis && \
#    cp -r $HOME/suma/web /var/www/html/suma/  && \
#    cp -r $HOME/suma/analysis /var/www/html/suma/ && \
#    cp -r $HOME/suma/service/* /var/www/html/sumaserver/ && \
#    cp $HOME/suma/service/web/htaccess_example /var/www/html/sumaserver/.htaccess && \
#    cp $HOME/suma/service/web/index.php /var/www/html/sumaserver/index.php
#COPY config/web-config.yaml /var/www/html/sumaserver/config/config.yaml
COPY config/apache2.conf /etc/apache2/apache2.conf
COPY config/web-config.yaml $HOME/Suma/service/web/config/config.yaml
COPY config/server-config.yaml $HOME/Suma/service/config/config.yaml
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
