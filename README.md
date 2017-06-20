# Dockerize-Django-MongoDB
# Connect your django project to a mongo database and run the full stack using docker tools

This wiki is intended to assist macOS & ubuntu users in running a django project connected to a non relational database (MongoDB) and running the stack using docker tools.
The process of creating the desired stack included testing different django versions and debugging to create the most stable working version.
The use of docker tools made it easy to re-build and try different plugins and different versions to make it work.

> "Docker is an open platform for building, shipping and running distributed applications. It gives programmers, development teams, and operations engineers the common toolbox they need to take advantage of the distributed and networked nature of modern applications."

Docker simply enables developers to run applications within standardized environments. Any changes can be reverted back and full environments are re-built within minutes or less. All you need to demonstrate the next tutorial is the following prerequisites installed on your system:
* Python 2.7
* Docker
* Docker-machine (macOS users, using Homebrew)
* Virtual Box (macOS users)


## Setting Up Docker for macOS users
Make sure you have docker tools, docker-machine and VirtualBox installed. Now, you can create your first docker-machine, which will is a virtual machine responsible for running docker containers.

    $ docker-machine create testbox --driver virtualbox  
    --virtualbox-disk-size "5000" --virtualbox-cpu-count 2
    --virtualbox-memory "4096"
    $ VBoxManage controlvm "testbox" natpf1 "tcp-port8000,tcp,,8000,,8000";

It's necessary to add some environmental variables to your current working terminal session. Failing to do so will stop the Docker command from affecting the virtual machine you've just created.(This should be done everytime you open a new terminal session)

    $ docker-machine start testbox
    $ docker-machine env testbox
    $ eval "$(docker-machine env testbox)"

## Using Dockerfiles
A Dockerfile is a set of instructions that docker uses to build a container or an image. The created container will be the virtual running host for your application. You can find ready to use images to build and through this tutorial you will create your own dockerfiles to build two containers. The first container is an ubuntu virtual machine running a mongoDB instance and saves the data on your actual system. The second container is also an ubuntu virtual machine running the django application(testproj) and enables it to connect to the database instance.
Before setting up your docker containers you should open settings.py inside your django project and edit or add the following variables to look like this:

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.dummy'
        }
    }
    AUTHENTICATION_BACKENDS = (
        'mongoengine.django.auth.MongoEngineBackend',
    )
    from mongoengine import *
    connect('testdb', host='[docker host ip]',  port=27017)

You can get your [docker host ip] through your terminal:
* For macOS

    $ docker-machine ip

* For ubuntu look for inet addr value inside docker0 network when you call:

    $ ifconfig

## Setting Up Docker Containers

    $ cd dockerfiles

Open setup.sh and edit the variable paths to point to your django project and where you wish to save your data. Use only absolute paths. Make sure port 8000 isn't used and then run the script to build and run your docker containers.

    $ ./setup.sh

Make sure your containers are running by calling docker ps and you can use the other scripts to stop, start & remove your containers.

Now, your django project should be accessible through the browser on localhost:8000

For more information on how to use mongoengine visit the [documentation](http://docs.mongoengine.org/tutorial.html)