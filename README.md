# lotus-docker

本仓库用于构建lotus docker镜像，包含 `lotus`、 `lotus-miner`、 `lotus-worker`三个组件。
其中lotus的版本号在`Makefile`文件的第一行中指定。

## Build docker image
由于墙内网络太慢，所以将`Dockerfile`拆分成了三个文件。 `lotus-build-env.dockerfile`（编译环境基础镜像）和`lotus-runtime.dockerfile`（运行环境基础镜像）已经提交到`hub.docker`。

只要执行下面这条命令就可以了
```
make build
```

这个过程中会从github下载lotus源码，如果网速太慢，可以从别处将下载好的`lotus`代码拷贝到本目录.
再修改`lotus.dockerfile`文件中的
```
RUN git clone https://github.com/filecoin-project/lotus.git --depth 1 --branch $BRANCH
```
改成
```
ADD lotus /go/lotus
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