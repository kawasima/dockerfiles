FROM openjdk:8-slim
MAINTAINER kawasima <kawasima1016@gmail.com>

RUN apt-get update \
    && apt-get install -y \
       curl git rlwrap

RUN curl -O https://download.clojure.org/install/linux-install-1.9.0.326.sh \
    && chmod +x linux-install-1.9.0.326.sh \
    && ./linux-install-1.9.0.326.sh
