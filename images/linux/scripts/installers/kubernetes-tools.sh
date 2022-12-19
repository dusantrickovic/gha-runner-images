#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize, kops
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install KIND
URL=$(get_github_package_download_url "kubernetes-sigs/kind" "contains(\"kind-linux-amd64\")")
curl -L -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_VERSION=$(curl -L -s "https://dl.k8s.io/release/stable.txt")
curl -o /usr/local/bin/kubectl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
chmod +x /usr/local/bin/kubectl

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -s "$download_url" | bash
mv kustomize /usr/local/bin

# Install kops
download_url="https://github.com/kubernetes/kops/releases/download"
KOPS_VERSION=$(curl -s "https://api.github.com/repos/kubernetes/kops/releases/latest" | grep tag_name | cut -d '"' -f 4)
package="kops-linux-amd64"
dest_directory="/usr/local/bin/kops"

curl -LO "$download_url/$KOPS_VERSION/$package"
chmod +x $package
sudo mv $package $dest_directory


invoke_tests "Tools" "Kubernetes tools"
