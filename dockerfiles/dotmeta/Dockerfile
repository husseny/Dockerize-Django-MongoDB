FROM  ubuntu:16.04
MAINTAINER Docker

RUN apt-get update

# Install python packages
RUN apt-get install -y python python-pip python-dev

WORKDIR /app/src
ADD requirements.txt /app/src/requirements.txt
RUN pip install -r requirements.txt
WORKDIR /app/src/djangoproj
EXPOSE 8000

ENTRYPOINT ["python",  "manage.py", "runserver", "0.0.0.0:8000"]