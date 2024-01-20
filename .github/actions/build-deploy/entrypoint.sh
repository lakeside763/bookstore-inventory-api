#!/usr/bin/env sh

# Checkout code
git clone $GITHUB_WORKSPACE /workspace

# Configure AWS credentials
aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
aws configure set region ${AWS_REGION}

# Login to ECR
$(aws ecr get-login --no-include-email --region ${AWS_REGION})

# Get short SHA
# SHA8=$(echo ${GITHUB_SHA} | cut -c1-8)

# Build, tag, and push image to ECR
docker build -f /workspace/src/Dockerfile -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} /workspace/src
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

# # Deploy to EKS with Helm
# aws eks --region ${AWS_REGION} update-kubeconfig --name ${EKS_CLUSTER_NAME}
# helm upgrade --install inventory-api-development ${HELM_CHART_PATH} \
#   --namespace development \
#   --set image.repository=${ECR_REGISTRY}/${ECR_REPOSITORY}:${SHA8},image.tag=latest

