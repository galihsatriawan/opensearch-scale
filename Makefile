
CHART = data
REPLICAS = 1

create-master:
	helm install opensearch-master opensearch/opensearch -f charts/master.yaml

create-data:
	helm install opensearch-data opensearch/opensearch -f charts/data.yaml

create-client:
	helm install opensearch-client opensearch/opensearch -f charts/client.yaml

create-dashboard: 
	helm install opensearch-dashboards opensearch/opensearch-dashboards

setup-environment:
	sh setup.sh

setup-opensearch: create-master create-data create-client create-dashboard delay

delay:
	echo "waiting for starting"
	sleep 60

expose-dashboard:
	kubectl port-forward deployment/opensearch-dashboards 5601

expose-opensearch:
	kubectl port-forward opensearch-cluster-master-0 9200

expose: expose-dashboard expose-opensearch

scale:
	kubectl scale sts/opensearch-cluster-${CHART} --replicas=${REPLICAS}

teardown: 
	helm delete opensearch-master opensearch-data opensearch-client opensearch-dashboards