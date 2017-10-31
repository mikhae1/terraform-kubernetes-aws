SHELL += -eu

BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

export DIR_KEY_PAIR   := .keypair
export DIR_SSL        := .cfssl
export DIR_KUBECONFIG := .kube

export AWS_REGION           ?= us-west-2
export COREOS_CHANNEL       ?= stable
export COREOS_VM_TYPE       ?= hvm
export CLUSTER_NAME         ?= kubernetes

export AWS_EC2_KEY_NAME     ?= ${USER}-$(CLUSTER_NAME)
export AWS_EC2_KEY_PATH     := ${DIR_KEY_PAIR}/${AWS_EC2_KEY_NAME}.pem
export INTERNAL_TLD         := ${CLUSTER_NAME}.${USER}

export HYPERKUBE_IMAGE      ?= quay.io/coreos/hyperkube
export HYPERKUBE_TAG        ?= v1.7.4_coreos.0

export CIDR_VPC             ?= 10.0.0.0/16
export CIDR_PODS            ?= 10.2.0.0/16
export CIDR_SERVICE_CLUSTER ?= 10.3.0.0/24

export K8S_SERVICE_IP       ?= 10.3.0.1
export K8S_DNS_IP           ?= 10.3.0.10

export ETCD_IPS             ?= 10.0.10.10,10.0.10.11,10.0.10.12

export PKI_IP               ?= 10.0.10.9

all: check_requirements create-keypair

check_requirements: ; @local/run "checking requirements" local/check_requirements

help: ; @echo 'Roll up Kubernetes cluster at AWS'

include local/makefiles/*.mk

.DEFAULT_GOAL := help
.PHONY: all help check_requirements
