FILES=`cat env`
.PHONY: list

list:
	@sh -c "$(MAKE) -p no_op__ | \
		awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);\
		for(i in A)print A[i]}' | \
		grep -v '__\$$' | \
		grep -v 'make\[1\]' | \
		grep -v 'Makefile' | \
		sort"

# required for list
no_op__:

build: buildx

buildx:
	docker buildx build --platform linux/arm/v7,linux/arm64/v8 -t buildingbananas/buzzer:latest .

build-local:
	docker build -t buildingbananas/buzzer:dev .

push:
	docker buildx build --platform linux/arm/v7,linux/arm64/v8 -t buildingbananas/buzzer:latest --push .

run:
	docker run --privileged -d --name buzzer -p 80:80 buildingbananas/buzzer:latest

dev: build-local
	docker run -it --rm -v $(HOME):/root -v $(PWD):/usr/src/app --env PYTHON_ENV="test" --name buzzer-dev -p 8000:80 buildingbananas/buzzer:dev

dev-shell: build-local
	@echo "uvicorn app.main:app --reload --host 0.0.0.0 --port 80"
	docker run -it --rm -v $(HOME):/root -v $(PWD):/code/ --env PYTHON_ENV="test" --name buzzer-dev -p 8000:80 buildingbananas/buzzer:dev /bin/bash

