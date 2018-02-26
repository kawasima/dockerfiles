FROM openjdk:8-slim

RUN apt-get update \
    && apt-get install -y curl jq

RUN curl https://circleci.com/api/v1.1/project/github/kawasima/rascaloid/latest/artifacts \
    | jq 'map(select(.["path"] == "home/circleci/repo/target/rascaloid-0.1.0-SNAPSHOT.jar"))' \
    | jq '.[0]["url"]' \
    | xargs curl -o rascaloid.jar

EXPOSE ${PORT}
ENTRYPOINT ["java", "-jar", "rascaloid.jar"]
