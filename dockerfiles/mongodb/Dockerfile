FROM  ubuntu:16.04
MAINTAINER Docker
 
RUN apt-get update

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get install -y --force-yes mongodb-org

VOLUME ["/data/db"]
WORKDIR /data

EXPOSE 27017
# Set /usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT ["mongod"]

