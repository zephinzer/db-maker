include ./Makefile.properties

DOCKERREPO=$(DOCKERUSER)/$(DOCKERIMAGE)

build:
	docker build -t $(DOCKERREPO):latest .


publish: build
	docker tag $(DOCKERREPO):latest $(DOCKERREGISTRY)/$(DOCKERREPO):latest
	docker push $(DOCKERREGISTRY)/$(DOCKERREPO):latest

publish.version: build
	docker run -v "$(shell pwd):/app" zephinzer/semver get-latest -q > ./.version
	docker tag $(DOCKERREPO):latest $(DOCKERREGISTRY)/$(DOCKERREPO):$(shell cat ./.version)
	docker push $(DOCKERREGISTRY)/$(DOCKERREPO):$(shell cat ./.version)
	rm -rf ./.version

iterate.version:
	docker run -v "$(shell pwd):/app" zephinzer/semver iterate
