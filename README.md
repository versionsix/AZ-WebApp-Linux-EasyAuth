# AZ-WebApp-Linux-EasyAuth

This git contains an example app for the azure web app. This is usefull to explore the EasyAuth functionallity of azure.

Build:
> `docker build -t az_webapp_linux_demo .`

Run locally:
> `docker run -it -p 8081:80 -p 2223:2222 az_webapp_linux_demo` 

Test locally:
> `http://localhost:8081`

Shell locally:

> `docker ps` => get *< CONTAINER ID >*

> `docker exec -it < CONTAINER ID > /bin/bash`

---
Push to container registry
> `docker login --username=yourhubusername --email=youremail@company.com`

Check Image ID
> `docker images`
```
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
az_webapp_linux_demo   latest              4a5eff1bf052        2 minutes ago       270MB
myapp                  latest              5edd63ea6035        14 minutes ago      270MB
```
Tag Image
> `docker tag  4a5eff1bf052 xenefix/az_webapp_linux_demo:demo`

Push Image
> `docker push xenefix/az_webapp_linux_demo`