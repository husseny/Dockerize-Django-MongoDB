#!/bin/bash

cd ..

# Build mongodb
cd mongodb
docker build -t dockerfile .

# Start mongodb in a detached mode pointing to a volume on your system to save the data
docker run  --name="mongodb_container" -v [Path to data folders]/data/db:/data/db  -itd -p 27017:27017 dockerfile

# Build django
cd ../dotmeta
docker build -t dockerfile .

# Start django in a detached mode pointing to your django application folder
docker run  --name="django_container"  -v [path to djangoproj]:/app/src/djangoproj  -itd -p 8000:8000  dockerfile

cd ..

# A couple of adjustments to the authentication files in django to be used smoothly with mongoDB 
docker cp django\ tweaks/model_fields/__init__.py django_container:/usr/local/lib/python2.7/dist-packages/django/db/models/fields/__init__.py

docker cp django\ tweaks/auth/__init__.py django_container:/usr/local/lib/python2.7/dist-packages/django/contrib/auth/__init__.py
