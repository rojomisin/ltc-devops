build: 
    @curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b .
    @./grype registry.gitlab.com/rojomisin/ltc-devops/litecoind:9 --only-fixed --fail-on low
