DOCKERHUB_NAMESPACE=hbouvier

all: konfd containerize publish

clean:
	@rm -f konfd

konfd: flags.go kubernetes.go main.go template.go
	GOOS=linux go build -a --ldflags '-extldflags "-static"' -tags netgo -installsuffix netgo .

containerize:
	docker build -t ${DOCKERHUB_NAMESPACE}/konfd:v0.0.4 .

publish:
	docker push ${DOCKERHUB_NAMESPACE}/konfd:v0.0.4
