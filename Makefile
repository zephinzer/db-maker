include ./Makefile.properties

DOCKERREPO=$(DOCKERUSER)/$(DOCKERIMAGE)

build:
	docker build -t $(DOCKERREPO):latest .


publish: build
	docker tag $(DOCKERREPO):latest $(DOCKERREGISTRY)/$(DOCKERREPO):latest
	docker push $(DOCKERREGISTRY)/$(DOCKERREPO):latest

iterate.version:
	docker run -v "$(shell pwd):/app" zephinzer/semver iterate
