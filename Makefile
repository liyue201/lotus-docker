BRANCH = v0.9.1

.PHONY: build
build:
	docker image build --build-arg BRANCH=$(BRANCH) -t stirlingx/lotus:$(BRANCH) -f lotus.dockerfile .

rebuild:
	docker image build --build-arg BRANCH=$(BRANCH) --no-cache -t stirlingx/lotus:$(BRANCH) -f lotus.dockerfile .

run:
	docker container run -p 1235:1235 -p 1234:1234 --detach --name lotus stirlingx/lotus:$(BRANCH)

run-bash:
	docker container run -p 1235:1235 -p 1234:1234 -it --entrypoint=/bin/bash --name lotus --rm stirlingx/lotus:$(BRANCH)

bash:
	docker exec -it lotus /bin/bash

sync-status:
	docker exec -it lotus lotus sync status

log:
	docker logs lotus -f

stop:
	docker stop lotus

rm:
	docker rm lotus
