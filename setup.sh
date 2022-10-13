## helm installation script based on https://helm.sh/docs/intro/install/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

## Add opensearch repo
helm repo add opensearch https://opensearch-project.github.io/helm-charts/

## update helm repo
helm repo update