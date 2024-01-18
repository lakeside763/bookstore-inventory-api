#!/bin/bash

# Checkout code
# git clone $GITHUB_WORKSPACE /workspace

# Configure AWS credentials
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION

# Login to ECR
$(aws ecr get-login --no-include-email --region $AWS_REGION)

# Get short SHA
SHA8=$(echo ${GITHUB_SHA} | cut -c1-8)

# Build, tag, and push image to ECR
docker build -f /src/Dockerfile -t $ECR_REGISTRY/$ECR_REPOSITORY:$SHA8 /src
docker push $ECR_REGISTRY/$ECR_REPOSITORY:$SHA8

# Deploy to EKS with Helm
# aws eks --region ${{ inputs.aws-region }} update-kubeconfig --name ${{ inputs.eks-cluster-name }}
# helm upgrade --install inventory-api-development ${{ inputs.helm-chart-path }} \
#   --namespace development \
#   --set image.repository=$ECR_REGISTRY/${{ inputs.ecr-repository }}:$SHA8,image.tag=latest

