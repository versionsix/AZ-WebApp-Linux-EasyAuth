# AZ-WebApp-Linux-EasyAuth

(Chose central US! Due to ?? not working in other regions)

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)


This git contains an example app for the azure web app. This is usefull to explore the EasyAuth functionallity of azure.

Build:
```
docker build -t az_webapp_linux_demo .
```

Run locally:
```
docker run -it \
   -p 8081:80 \
   -p 2223:2222 \
   -e "SITE_MY_PARAMETER_1=quux" \
   -v home:/home \
   az_webapp_linux_demo
``` 
_Note: the home directory is also present on azure. It's a persistent storage cifs mount._

Test locally:
```
http://localhost:8081
```

Shell locally:

```
docker ps` => get *< CONTAINER ID >*

docker exec -it < CONTAINER ID > /bin/bash
```

---
Push to container registry
```
docker login --username=yourhubusername --email=youremail@company.com
```

Check Image ID
```
docker images
```

```
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
az_webapp_linux_demo   latest              4a5eff1bf052        2 minutes ago       270MB
myapp                  latest              5edd63ea6035        14 minutes ago      270MB
```
Tag Image
```
docker tag az_webapp_linux_demo:latest xenefix/az_webapp_linux_demo:demo
```

Push Image
```
docker push xenefix/az_webapp_linux_demo:demo
```

<br>

>Example on docker hub: https://hub.docker.com/r/xenefix/az_webapp_linux_demo/