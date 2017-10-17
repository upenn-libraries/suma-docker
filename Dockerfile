FROM ubuntu:16.04
MAINTAINER Jeremy Nelson <jermnelson@gmail.com>, Jon Driscoll <jdriscoll@coloradocollege.edu>
ENV HOME /var/www/app/suma
COPY Suma/ $HOME/
RUN ln -s $HOME/service/web/ /var/www/htdocs/sumaserver/ && \
    ln -s $HOME/web/ /var/www/htdocs/suma/client/ && \
    ln -s $HOME/analysis/ /var/www/htdocs/suma/analysis
