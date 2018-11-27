# Druid Docker Image

## Run a simple Druid cluster

[Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Download and launch the docker image

```sh
docker-compose pull
docker network create --subnet=172.18.0.0/16 zenatix-docker
docker-compose up -d druid-postgresql
```
With postgres up, we will initiate the metadata db.

```sh
docker-compose run druid-init
```
Now with migrations applied, we can start the services in the following order.

```sh
docker-compose up -d druid-zookeeper
docker-compose up -d druid-coordinator
docker-compose up -d druid-broker
docker-compose up -d druid-historical
```

## Build Druid Docker Image

To build the docker image yourself

```sh
git clone https://github.com/Zenatix-Tech/docker-druid
docker-compose build
```

## Sending data

For now we copy the data inside the coordinator container using:
`docker cp ingest.json druid-coordinator:/var/lib/druid/ingest.json`

Then we specify the ingest job via a curl request (here spec.json is the specification file present in current directory):
`curl -X 'POST' -H 'Content-Type:application/json' -d @spec.json http://localhost:8081/druid/indexer/v1/task`

You should get something like this as response:
`{"task":"index_2018-11-26T11:47:33.694Z"}`

You can use the task id to get more details about the job status as:
`curl http://localhost:8081/druid/indexer/v1/task/index_2018-11-27T09:20:48.623Z/status`

This should get you response as:
`{"task":"index_2018-11-27T09:20:48.623Z","status":{"id":"index_2018-11-27T09:20:48.623Z","status":"SUCCESS","duration":64345}}`

## Resource Requirement

Druid is quite memory intensive and recommended configuration for development (i.e. resources that must be available) is 4 Cores and 8 GB RAM, though you can get by builds and bare functionality at 2 Cores and 4 GB RAM.
