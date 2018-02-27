FROM clojure:lein

RUN git clone https://github.com/kawasima/rascaloid-ri.git
WORKDIR rascaloid-ri
RUN lein with-profile docker install
ENTRYPOINT ["lein", "with-profile", "docker", "run", "rascaloid.edn"]
