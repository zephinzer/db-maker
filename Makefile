include ./Makefile.properties

DOCKERREPO=$(DOCKERUSER)/$(DOCKERIMAGE)

build:
	docker build -t $(DOCKERREPO):latest .


publish: build
	docker tag $(DOCKERREPO):latest $(DOCKERREGISTRY)/$(DOCKERREPO):latest
	docker push $(DOCKERREGISTRY)/$(DOCKERREPO):latest

publish.version: build
	$(eval TAG=$(shell docker run -v "$(shell pwd):/app" zephinzer/semver get-latest -q))
	docker tag $(DOCKERREPO):latest $(DOCKERREGISTRY)/$(DOCKERREPO):$(TAG)
	docker push $(DOCKERREGISTRY)/$(DOCKERREPO):$(TAG)

iterate.version:
	docker run -v "$(shell pwd):/app" zephinzer/semver iterate
