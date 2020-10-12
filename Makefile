BRANCH = v0.9.1

build:
	docker image build -t stirlingx/lotus:latest -f lotus.dockerfile .

rebuild:
	docker image build --no-cache -t stirlingx/lotus:latest -f lotus.dockerfile .

run:
	docker container run -p 1235:1235 -p 1234:1234 --detach --name lotus stirlingx/lotus:latest

run-bash:
	docker container run -p 1235:1235 -p 1234:1234 -it --entrypoint=/bin/bash --name lotus --rm stirlingx/lotus:latest

bash:
	docker exec -it lotus /bin/bash

sync-status:
	docker exec -it lotus lotus sync status

log:
	docker logs lotus -f

rm:
	docker rm lotus
