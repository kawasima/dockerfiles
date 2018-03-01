FROM openjdk:8-alpine

ARG BOUNCR_VERSION=0.1.4-SNAPSHOT
RUN apk --no-cache add curl jq

RUN curl https://circleci.com/api/v1.1/project/github/kawasima/bouncr/latest/artifacts \
    | jq "map(select(.[\"path\"] == \"home/circleci/repo/target/bouncr-${BOUNCR_VERSION}.jar\"))" \
    | jq '.[0]["url"]' \
    | xargs curl -o bouncr.jar

RUN apk del --purge curl jq

ENTRYPOINT ["java", "-jar", "bouncr.jar"]
