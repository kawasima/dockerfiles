# A basic apache server. To use either add or bind mount content under /var/www
FROM stackbrew/ubuntu:saucy

MAINTAINER kawasima: 0.1

RUN apt-get update && apt-get install -y apache2 git ruby bundler mysql-server libmysqlclient-dev

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

RUN mkdir /var/lib/rack
RUN cd /var/lib/rack && git clone https://github.com/kawasima/cert-publisher.git
RUN cd /var/lib/rack/cert-publisher ;\
    git checkout develop ;\
    bundle install ;\
    chown -R www-data:www-data .
CMD cd /var/lib/rack/cert-publisher && rackup

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
