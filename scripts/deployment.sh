#!/bin/bash


if [[ $BRANCH_NAME == "main" ]]; then
	export NAMESPACE="boshi";
else
	export NAMESPACE="boshi-$BRANCH_NAME";
fi

if kubectl get namespace $NAMESPACE >/dev/null 2>&1; then
	kubectl rollout restart deployment boshi-backend -n $NAMESPACE
else
	kubectl create namespace $NAMESPACE
	kubectl create deployment boshi-backend --image=$REGISTRY/boshi-backend:$BRANCH_NAME-latest --port=80 -n $NAMESPACE
	kubectl expose deployment boshi-backend --name=boshi-svc --port=80 --target-port=80 --type=ClusterIP -n $NAMESPACE
	kubectl create ingress ingress --annotation cert-manager.io/cluster-issuer="letsencrypt-prod" --class=nginx --rule="$BRANCH_NAME-api-boshi.deguzman.cloud/*=boshi-svc:80,tls=boshi-tls" -n $NAMESPACE
fi

