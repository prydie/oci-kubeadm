#!/usr/bin/env bash

echo "Running basic setup"

# Disable swap
swapoff -a

# Update system
yum update -y

# Disable SELinux
setenforce 0

# Remove existing Docker packages
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-selinux \
           docker-engine-selinux \
           docker-engine

# Install Docker prerequisites 
yum install -y \
    yum-utils \
    device-mapper-persistent-data \
    lvm2

# Install Docker CE
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo    
yum install -y docker-ce

# Add current user to Docker group
usermod -aG docker $(whoami)

systemctl enable docker.service
