#!/bin/bash -e -o pipefail

################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, kops
################################################################################

# Check if Homebrew is installed and update it if so
if [[ $(command -v brew) == "" ]]; then
    echo "No Homebrew found. Installing necessary tools..." && echo ""
    homebrew_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source ${homebrew_script_dir}/homebrew.sh
else
    echo "Updating Homebrew"
    brew update
fi

# Install Kind
brew install kind

# Install kubectl (prerequisite)
brew install kubectl

# Install Helm
brew install helm

# Install minikube
brew install minikube

# Install kustomize
brew install kustomize

# Install kops
brew install kops

invoke_tests "Kubernetes" "Kubernetes tools"