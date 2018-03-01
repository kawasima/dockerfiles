FROM alpine AS build

ARG RASCALOID_VERSION=0.1.0-SNAPSHOT
ARG dbtype=h2
RUN apk --no-cache add curl jq libxml2-utils bash

RUN mkdir /rascaloid
WORKDIR /rascaloid
RUN curl 'https://circleci.com/api/v1.1/project/github/kawasima/rascaloid/latest/artifacts?branch=develop&filter=successful' \
    | jq "map(select(.[\"path\"] == \"home/circleci/repo/target/rascaloid-${RASCALOID_VERSION}.jar\"))" \
    | jq '.[0]["url"]' \
    | xargs curl -o rascaloid.jar

ADD fetch_jdbc_driver.sh /usr/local/bin
RUN fetch_jdbc_driver.sh $dbtype

RUN apk del --purge curl jq libxml2-utils

FROM openjdk:8-alpine
COPY --from=build /rascaloid/ /rascaloid/
WORKDIR rascaloid
ENTRYPOINT ["java", "-cp", "rascaloid.jar:runtime/*", "net.unit8.rascaloid.Main"]
