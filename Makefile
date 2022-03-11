
build:
	@echo "run docker build"
	@docker build --platform linux/amd64 .

scan:
	@echo "run grype container scan"
	@curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b .
	@./grype registry.gitlab.com/rojomisin/ltc-devops/litecoind:9 --only-fixed --fail-on low

push:
	@echo "push to docker container reg"

deploy:
	@echo "kubernetes ss update"

clean:
	@echo "clean up stuff"

all: pre build scan push deploy clean
