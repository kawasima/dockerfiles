FROM openjdk:8-slim

ENV VERSION 2.2.3

RUN apt-get update \
    && apt-get install -y curl procps

RUN curl -sSLo /apache-archiva-$VERSION-bin.tar.gz http://archive.apache.org/dist/archiva/$VERSION/binaries/apache-archiva-$VERSION-bin.tar.gz \
    && tar --extract --ungzip --file apache-archiva-$VERSION-bin.tar.gz --directory / \
    && rm /apache-archiva-$VERSION-bin.tar.gz \
    && mv /apache-archiva-$VERSION /apache-archiva

RUN useradd -d /apache-archiva/data -m archiva \
  && rm /apache-archiva/conf/archiva.xml \
  && ln -s /apache-archiva/data/archiva.xml /apache-archiva/conf/archiva.xml \
  && mkdir /apache-archiva/repositories \
  && chown archiva:archiva /apache-archiva/logs /apache-archiva/repositories /apache-archiva/temp

ENV ARCHIVA_BASE /apache-archiva

COPY archiva.xml /apache-archiva/data/archiva.xml
ADD init.sh /usr/local/bin
RUN init.sh && rm /usr/local/bin/init.sh
RUN chown archiva:archiva /apache-archiva/data/archiva.xml

WORKDIR /apache-archiva

USER archiva

VOLUME /apache-archiva/data
VOLUME /apache-archiva/logs
VOLUME /apache-archiva/repositories/internal
VOLUME /apache-archiva/temp
VOLUME /apache-archiva/conf

EXPOSE 8080/tcp

ENTRYPOINT ["bin/archiva", "console"]
