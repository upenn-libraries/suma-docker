FROM ubuntu:16.04
MAINTAINER Jeremy Nelson <jermnelson@gmail.com>, Jon Driscoll <jdriscoll@coloradocollege.edu>
ENV HOME /var/www/app
RUN apt-get update && apt-get install -y apache2 apache2-dev git python-mysqldb 
RUN apt-get install -y php php-mcrypt php-mysql 

ADD Suma $HOME/suma
#RUN cd $HOME/suma && ls -ltra && \
#    ln -s $HOME/service/web/ /var/www/htdocs/sumaserver/ && \
#    ln -s $HOME/web/ /var/www/htdocs/suma/client/ && \
#    ln -s $HOME/analysis/ /var/www/htdocs/suma/analysis/

RUN cd /var/www/html && mkdir suma && mkdir sumaserver && \
    cd suma && mkdir web && mkdir analysis && \
    cp -r $HOME/suma/web /var/www/html/suma/  && \
    cp -r $HOME/suma/analysis /var/www/html/suma/ && \
    cp -r $HOME/suma/service/* /var/www/html/sumaserver/ && \
    cp $HOME/suma/service/web/htaccess_example /var/www/html/sumaserver/.htaccess && \
    cp $HOME/suma/service/web/index.php /var/www/html/sumaserver/index.php
#COPY config/web-config.yaml /var/www/html/sumaserver/config/config.yaml
COPY config/web-config.yaml $HOME/suma/service/web/config/config.yaml
COPY config/server-config.yaml $HOME/suma/service/config/config.yaml
EXPOSE 80
EXPOSE 19679
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
