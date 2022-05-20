# goeland docker service

A distroless [goeland](https://github.com/slurdge/goeland) Docker image that runs as a daemon.

## building

To build for your architecture:

```sh
./build.sh
```

## usage

Run the container once with `docker-compose run goeland` to create the `config.toml`. Edit that file according to your preferences. Be sure to add `database = "/data/goeland.db"` so that the database is stored in the mounted volume.

The config file is reloaded at every interval.

For more usage details, see the [goeland repo](https://github.com/slurdge/goeland).
