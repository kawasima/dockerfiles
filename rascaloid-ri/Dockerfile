FROM clojure:lein

RUN git clone https://github.com/kawasima/rascaloid-ri.git
WORKDIR rascaloid-ri
RUN lein deps
ENTRYPOINT ["lein", "run", "rascaloid.edn"]
