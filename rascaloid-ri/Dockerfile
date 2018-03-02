FROM clojure:lein-alpine

RUN apk add --no-cache git
RUN git clone https://github.com/kawasima/rascaloid-ri.git
RUN apk del --purge git
WORKDIR rascaloid-ri
RUN lein with-profile docker install
ENTRYPOINT ["lein", "with-profile", "docker", "run", "rascaloid.edn"]
