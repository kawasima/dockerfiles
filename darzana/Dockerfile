# A basic apache server. To use either add or bind mount content under /var/www
FROM ubuntu:12.10

MAINTAINER kawasima: 0.1

ENV LEIN_ROOT 1

RUN apt-get update
RUN apt-get install -y git curl openjdk-7-jre-headless

RUN curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
RUN chmod +x /usr/local/bin/lein
RUN lein upgrade

EXPOSE 3000

RUN cd /home; git clone https://github.com/kawasima/darzana.git 
RUN useradd -d /home/darzana darzana
RUN chown -R darzana:darzana /home/darzana 
CMD cd /home/darzana; su -c "lein ring server-headless" darzana

