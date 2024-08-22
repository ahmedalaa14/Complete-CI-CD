#!/bin/bash

# Stop running container
docker stop python-app || true

# Remove stopped container
docker rm python-app || true

# Remove used image
docker rmi ahmedalaa14/flask-app-min || true

# Build new image
docker build -t ahmedalaa14/flask-app-min .

# Push docker image
docker push ahmedalaa14/flask-app-min

# Run new container
docker run -d --name python-app -p 5000:5000 ahmedalaa14/flask-app-min