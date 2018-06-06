#!/bin/sh

set -e

if [ "$#" -ne 1 ]; then
    echo "USAGE: deploy.sh <version>"
    exit 1
fi

version=$1

function active_deployment_count() {
    deployments=$(kubectl get deployments -l app=hellodotnet -o jsonpath='{.items[*].metadata.name}')
    echo ${deployments} | wc -w
}

case $(active_deployment_count) in
0)
    echo "version: ${version}" | mustache - deployment.yaml.mustache > deployment.yaml
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
    ;;
1)
    echo "version: ${version}" | mustache - deployment-canary.yaml.mustache > deployment-canary.yaml
    kubectl apply -f deployment-canary.yaml
    ;;
*)
    (>&2 echo "More than one deployment already exist!")
    exit 1
esac

kubectl rollout status deployment "hellodotnet-${version}" # wait for deployments
