# rttys

This Helm chart helps to deploy [rttys](https://github.com/zhaojh329/rttys) to the Kubernetes clusters. It is mainly used in [assembly chart](https://github.com/Telecominfraproject/wlan-cloud-ucentral-deploy/tree/main/chart) as uCentral dependency, but may also be used as for standalone deployments.

Charts was tested with 2 rttys versions - 3.5.0 and 3.6.0. Version 3.5.0 is using SQLite for data storage so it doesn't require MySQL deployment, while 3.6.0 requires MySQL. Find details in [configuration](#configuration) on how to use both versions. By default this chart deploys version 3.5.0 without MySQL.

## TL;DR;

```bash
$ helm install .
```

## Introduction

This chart bootstraps an rttys on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

Currently this chart is not assembled in charts archives, so [helm-git](https://github.com/aslafy-z/helm-git) is required for remote the installation

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release git+https://github.com/Telecominfraproject/wlan-cloud-ucentralgw-rtty@helm?ref=main
```

The command deploys rttys on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete --purge my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default values. If Default value is not listed in the table, please refer to the [Values](values.yaml) files for details.

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `replicaCount` | number | Defines how many instances of application should be deployed | `1` |
| `nameOverride` | string | Override to be used for application deployment |  |
| `fullnameOverride` | string | Override to be used for application deployment (has priority over nameOverride) |  |
| `images.rttys.repository` | string | Docker image repository for rttys |  |
| `images.rttys.tag` | string | Docker image tag for rttys | `'3.5.0'` |
| `images.rttys.pullPolicy` | string | Docker image pull policy for rttys | `'IfNotPresent'` |
| `images.dockerize.repository` | string | Docker image repository for dockerize (used for MySQL reachability checks) | `'jwilder/dockerize'` |
| `images.dockerize.tag` | string | Docker image tag for dockerize | `'0.6.1'` |
| `images.dockerize.pullPolicy` | string | Docker image pull policy for dockerize | `'IfNotPresent'` |
| `services.rttys.type` | string | rttys service type | `'NodePort'` |
| `services.rttys.ports.dev.servicePort` | number | rttys devices endpoint port to be exposed on service | `5912` |
| `services.rttys.ports.dev.targetPort` | number | rttys devices endpoint port to be targeted by service | `5912` |
| `services.rttys.ports.dev.protocol` | string | rttys devices endpoint protocol | `'TCP'` |
| `services.rttys.ports.web.servicePort` | number | rttys web endpoint port to be exposed on service | `5914` |
| `services.rttys.ports.web.targetPort` | number | rttys web endpoint port to be targeted by service | `5914` |
| `services.rttys.ports.web.protocol` | string | rttys devices endpoint protocol | `'TCP'` |
| `services.rttys.ports.user.servicePort` | number | rttys user endpoint port to be exposed on service | `5913` |
| `services.rttys.ports.user.targetPort` | number | rttys user endpoint port to be targeted by service | `5913` |
| `services.rttys.ports.user.protocol` | string | rttys user endpoint protocol | `'TCP'` |
| `checks.rttys.liveness.httpGet.port` | string | Liveness check port to be used | `'user'` |
| `checks.rttys.liveness.httpGet.scheme` | string | Liveness check schema to be used | `'HTTPS'` |
| `checks.rttys.readiness.httpGet.port` | string | Readiness check path to be used | `'user'` |
| `checks.rttys.readiness.httpGet.scheme` | string | Readiness check schema to be used | `'HTTPS'` |
| `ingresses.default.enabled` | boolean | Defines if rttys should be exposed via Ingress controller | `False` |
| `ingresses.default.hosts` | array | List of hosts that will be exposed |  |
| `ingresses.default.paths` | array | List of paths to be exposed |  |
| `volumes.rttys` | array | Defines list of volumes to be attached to rttys |  |
| `mysql.enabled` | boolean | Defines if MySQL should be deployed in Kubernetes (read notes below) | `False` |
| `mysql.host` | string | Defines MySQL host that should be used for external MySQL connection | `'localhost'` |
| `mysql.image.registry` | string | Docker image registry for MySQL | `'docker.io'` |
| `mysql.image.repository` | string | Docker image repository for MySQL | `'bitnami/mysql'` |
| `mysql.image.tag` | string | Docker image tag for MySQL | `'5.7.34-debian-10-r44'` |
| `mysql.auth.rootPassword` | string | MySQL root password | `'rootPassword'` |
| `mysql.auth.database` | string | MySQL database to be created and connected to | `'rttys'` |
| `mysql.auth.username` | string | MySQL user to be created and used for connections | `'rttys'` |
| `mysql.auth.password` | string | MySQL password for user above | `'rttys'` |
| `mysql.primary.persistence.size` | string | MySQL persistend volume size | `'10Gi'` |
| `config.token` | string | rttys token to be used for application |  |
| `config.whiteList` | string | List of hosts that may connect to rttys | `'*'` |
| `config.httpUsername` | string | http-username config directive parameter (for 3.5.0) | `'rttys'` |
| `config.httpPassword` | string | http-password config directive parameter (for 3.5.0) | `'rttys'` |
| `certs."restapi-cert\.pem"` | string | Certificate that will be used by rttys HTTPS endpoint |  |
| `certs."restapi-key\.pem"` | string | Private key that will be used by rttys HTTPS endpoint |  |
| `certs."restapi-ca\.pem"` | string | CA that will be used by rttys HTTPS endpoint |  |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set replicaCount=1 \
    .
```

The above command sets that only 1 instance of your app should be running

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml .
```

> **Tip**: You can use the default [values.yaml](values.yaml) as a base for customization.

As it was stated above, this chart does supports 2 versions of rttys, but depending on what version you'd like to deploy, you'd need to pass different parameters to the application.

If you want to deloy rttys with version 3.5.0, you can simply use default values with default image and it should generate correct config file.

If you want to deploy rttys 3.6.0 with database running in Kubernetes, following values must be passed:

- `images.rttys.tag` = 3.6.0 -- this defines what version should be used
- `mysql.enabled` = true -- this defines that we want to deploy MySQL in Kubernetes as chart dependency
- `mysql.auth` -- defines database credentials for MySQL instance and database name

If you want to deploy rttys 3.6.0 with external database, following values must be passed:

- `images.rttys.tag` = 3.6.0 -- this defines what version should be used
- `mysql.enabled` = false -- this defines that we don't want to deploy MySQL in Kubernetes, but rather use external database
- `mysql.host` = FQDN -- this defines what external host is running MySQL instance that rttys should be connecting to
- `mysql.auth` -- defines database credentials for connection