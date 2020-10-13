# lotus-docker

This is a repo for building lotus into a docker image, which includes `lotus`, `lotus-miner` and `lotus-worker`.
See the first line of `Makefile` for the version of lotus.

## Build docker image

```
make build-env
make build-runtime
make build
```

## Run lotus daemon

```
make run 
```

## Stop lotus daemon

```
make stop 
```

## Show lotus's log

```
make log 
```