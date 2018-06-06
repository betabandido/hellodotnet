#!/bin/sh

set -e

deployments=$(kubectl get deployments -l app=hellodotnet --sort-by='{.metadata.creationTimestamp}' \
    | tail -n +2 \
    | cut -d' ' -f 1 \
)

deployment_count=$(echo ${deployments} | wc -w)

if [ "${deployment_count}" -ne 2 ]
then
    (>&2 echo "There must exist two deployments!")
    exit 1
fi

current_deployment=$(echo ${deployments} | cut -d' ' -f 1)
canary_deployment=$(echo ${deployments} | cut -d' ' -f 2)

function wait_for_deployment {
    deployment=$1
    kubectl rollout status deployment ${deployment}
}

kubectl scale --replicas=10 deploy ${canary_deployment}
wait_for_deployment ${canary_deployment}

kubectl delete deploy ${current_deployment}
