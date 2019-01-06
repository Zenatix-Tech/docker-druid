# Druid Docker Image

## Run a simple Druid cluster

[Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Download and launch the docker image

```sh
docker-compose pull
docker network create --subnet=172.18.0.0/16 zenatix-docker
docker-compose up -d druid-postgresql
docker-compose up -d druid-zookeeper
```
With postgres and zookeeper up, we can start the services in the following order.

```sh
docker-compose up -d druid-coordinator
docker-compose up -d druid-broker
docker-compose up -d druid-overlord
docker-compose up -d druid-middlemanager
docker-compose up -d druid-historical
```

## Build Druid Docker Image

To build the docker image yourself, you only build one image shared amongst all containers

```sh
git clone https://github.com/Zenatix-Tech/docker-druid
docker-compose build #Builds only druid-zookeeper via Dockerfile
```

## Sending data

For now we use `druid-volume` for everything, which is mounted to `/var/druid`. We start by placing both the `ingest-spec.json` and `ingest-data.json` inside the data directory, which makes it available inside all the containers.

Then we specify the ingest job via a curl request (here ingest-spec.json is the specification file present in data directory):

```
curl -X 'POST' -H 'Content-Type:application/json' -d @data/ingest-spec.json http://localhost:8081/druid/indexer/v1/task
```

You should get something like this as response:

`{"task":"index_2018-11-26T11:47:33.694Z"}`

You can use the task id to get more details about the job status as:

```
curl http://localhost:8081/druid/indexer/v1/task/index_2018-11-27T09:20:48.623Z/status
```

This should get you response as:

`{"task":"index_metrics_2019-01-06T08:14:11.406Z","status":{"id":"index_metrics_2019-01-06T08:14:11.406Z","type":"index","createdTime":"2019-01-06T08:14:11.408Z","queueInsertionTime":"1970-01-01T00:00:00.000Z","statusCode":"SUCCESS","status":"SUCCESS","runnerStatusCode":"WAITING","duration":89717,"location":{"host":null,"port":-1,"tlsPort":-1},"dataSource":"metrics","errorMsg":null}}`

## Resource Requirement

Druid is quite memory intensive and recommended configuration for development (i.e. resources that must be available) is 4 Cores and 8 GB RAM, though you can get by builds and bare functionality at 2 Cores and 4 GB RAM.

## Hack

We need to create a temporary directory manually for Druid. Use following to get into any Druid coordinator.

```
docker exec -it druid-historical bash
```

Then execute the following:

```bash
mkdir /var/druid/tmp
```