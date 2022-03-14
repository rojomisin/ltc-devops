# ltc-devops

run litecoind in a container on gke


### 1
[litecoind Dockerfile](Dockerfile)
- uploads to gitlab container registry

### 2
[litecoind StatefulSet on GKE](ss-ltc-devops.yaml)
- using gke disks instead of pv
- gke screenshots
  - [stateful set details](img/gke1.png)
  - [log output](img/gke2.png)

### 3
[travis ci-cd ](.travis.yml)
- secrets encrypted
- security scan
- deployed to gke on main branch
- <https://app.travis-ci.com/github/rojomisin/ltc-devops>

### 4 & 5
[simple cli for temperature conversion in rust](rust-temp-conv)
- `cargo run 80f` or `cargo run 22c

### 6
[tf aws iam](tf-iam)
- aws iam tf module
- `terraform plan`
- `terraform apply`