REGISTRY?=test.domain.com/infra

build: docker_build docker_push

docker_build:
	docker build --build-arg=http_proxy=${http_proxy} --build-arg=https_proxy=${http_proxy} -t $(REGISTRY)/$(PACKAGE):$(IMAGE_VERSION) .

push: docker_push

docker_push:
	docker push ${REGISTRY}/$(PACKAGE):${IMAGE_VERSION}

push_release:
	docker push ${NEW_REGISTRY}/$(PACKAGE):${IMAGE_VERSION}

retag:
	docker tag ${REGISTRY}/${PACKAGE}:${IMAGE_VERSION}${IMAGE_TAG} ${NEW_REGISTRY}/${PACKAGE}:${IMAGE_VERSION}