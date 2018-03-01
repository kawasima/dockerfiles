FROM openjdk:8-alpine

ARG ROTOM_VERSION=0.1.0-SNAPSHOT
RUN apk --no-cache add curl jq

RUN curl https://circleci.com/api/v1.1/project/github/kawasima/rotom/latest/artifacts \
    | jq "map(select(.[\"path\"] == \"home/circleci/repo/target/rotom-${ROTOM_VERSION}.jar\"))" \
    | jq '.[0]["url"]' \
    | xargs curl -o rotom.jar

RUN apk del --purge curl jq

ENTRYPOINT ["java", "-jar", "rotom.jar"]
