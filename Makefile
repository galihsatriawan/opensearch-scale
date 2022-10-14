
CHART = data
REPLICAS = 1
ARCH = separate
ARCH_VAR = SEPARATE

SETUP_OS_COMMAND = create-master create-data create-client create-dashboard delay
SUFFIX_CLUSTER_NAME= -separate

ifeq ($(ARCH), two-master)
SUFFIX_CLUSTER_NAME = -two-master
ARCH_VAR = TWO_MASTER
SETUP_OS_COMMAND = create-master create-client create-dashboard delay
endif

OS_SEPARATE_PORT = 9200
DASHBOARDS_SEPARATE_PORT = 5601

OS_TWO_MASTER_PORT = 8200
DASHBOARDS_TWO_MASTER_PORT = 4601

OS_PORT = $(OS_$(ARCH_VAR)_PORT)
DASHBOARDS_PORT = $(DASHBOARDS_$(ARCH_VAR)_PORT)

create-master:
	helm install opensearch-master-${ARCH} opensearch/opensearch -f charts-${ARCH}/master.yaml

create-data:
	helm install opensearch-data-${ARCH} opensearch/opensearch -f charts-${ARCH}/data.yaml

create-client:
	helm install opensearch-client-${ARCH} opensearch/opensearch -f charts-${ARCH}/client.yaml

create-dashboard: 
	helm install opensearch-dashboards-${ARCH} opensearch/opensearch-dashboards -f charts-${ARCH}/dashboards.yaml

setup-environment:
	sh setup.sh

setup-opensearch: $(SETUP_OS_COMMAND)

delay:
	echo "waiting for starting"
	sleep 60

expose-dashboard:
	kubectl port-forward deployment/opensearch-dashboards-${ARCH} ${DASHBOARDS_PORT}:5601

expose-opensearch:
	kubectl port-forward opensearch-cluster${SUFFIX_CLUSTER_NAME}-master-0 ${OS_PORT}:9200

expose: expose-dashboard expose-opensearch

scale:
	kubectl scale sts/opensearch-cluster${SUFFIX_CLUSTER_NAME}-${CHART} --replicas=${REPLICAS}

teardown: 
	helm delete opensearch-master-${ARCH}; helm delete opensearch-data-${ARCH} ; helm delete opensearch-client-${ARCH} ; helm delete opensearch-dashboards-${ARCH}