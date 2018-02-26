FROM maven:3.5-slim

RUN apt-get update \
    && apt-get install -y git

RUN git clone https://github.com/kawasima/rascaloid.git \
    && cd rascaloid \
    && git checkout develop

WORKDIR rascaloid
RUN mvn -P-dev,container -e compile dependency:go-offline

EXPOSE ${PORT}
ENTRYPOINT ["mvn", "-P-dev,container", "-e", "integration-test"]
