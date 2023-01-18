FROM alpine

RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add openjdk19@testing
ENV JAVA_HOME=/usr/lib/jvm/java-19-openjdk/jre
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-19-openjdk/jre/bin:/usr/lib/jvm/java-19-openjdk/bin

RUN apk add curl jq

WORKDIR /usr/share/udemy

ADD target/selenium-docker.jar			selenium-docker.jar
ADD target/selenium-docker-tests.jar	selenium-docker-tests.jar
ADD target/libs							libs
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml

RUN wget https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE

ENTRYPOINT sh healthcheck.sh