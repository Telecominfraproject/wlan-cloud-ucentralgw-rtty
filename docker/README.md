This Dockerfile was created as a fix for a [stock rttys Dockerfile](https://github.com/zhaojh329/rttys/blob/master/Dockerfile) as it seems to be outdated and broken

Dockerfile supports deployment of specific application version by checking out git repo to required ref. For example, if version 3.5.0 is required to be built, you can run following command:

```
docker build . --build-arg RTTYS_VERSION=v3.5.0 -t rttys:3.5.0
```
