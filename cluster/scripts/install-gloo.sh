#!/usr/bin/env bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

curl -LO https://git.io/get_helm.sh
chmod 700 get_helm.sh
ls -ld /etc/sudoers
chmod 440 /etc/sudoers

./get_helm.sh

helm repo add gloo https://storage.googleapis.com/solo-public-helm
helm repo update

helm install gloo gloo/gloo \
  --create-namespace \
  --namespace gloo-system \
  -f "$DIR/values.yaml"

true