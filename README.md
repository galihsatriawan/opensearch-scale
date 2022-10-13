# OpenSearch with helm-charts
Help us to install a local [OpenSearch](https://opensearch.org/) with easy scale.

## Prerequisite
* [Kubernetes](https://kubernetes.io/) (You can use anything you prefer, be it [minikube](https://minikube.sigs.k8s.io/docs/tutorials/), [kind](https://kind.sigs.k8s.io/docs/user/quick-start/), etc.)
* [Make](https://www.gnu.org/software/make/)
* A minimum of 4GiB of memory

## Installation
1.  Setup Environment

 ```make setup-environment```

2. Setup Opensearch 

 ```make setup-opensearch```

3. Run Opensearch

 ```make -j2 expose```
 
## Optional Command
* Scale an OpenSearch node

 ```make scale CHART=data REPLICAS=2```
 
* Uninstall all opensearch

 ```make teardown```