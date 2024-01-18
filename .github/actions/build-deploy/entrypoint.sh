#!/bin/bash
#!/bin/sh -l

# Set AWS credentials
echo "::add-mask::${AWS_ACCESS_KEY_ID}"
echo "::add-mask::${AWS_SECRET_ACCESS_KEY}"

aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
aws configure set region "${AWS_REGION}"

# Authenticate Docker to Amazon ECR
aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${ECR_REGISTRY}"

# Get short SHA
SHA8=$(echo "${GITHUB_SHA}" | cut -c1-8)

# Build, tag, and push image to ECR
docker build -f src/Dockerfile -t "${ECR_REGISTRY}/${ECR_REPOSITORY}:${SHA8}" ./src
docker push "${ECR_REGISTRY}/${ECR_REPOSITORY}:${SHA8}"

# Deploy to EKS with Helm
# aws eks --region "${AWS_REGION}" update-kubeconfig --name "${AWS_CLUSTER_NAME}"
# helm upgrade --install inventory-api-development "${HELM_CHART_PATH}" \
#   --namespace development \
#   --set image.repository="${ECR_REGISTRY}/${ECR_REPOSITORY}",image.tag="${SHA8}"













#-------------------------------

# Checkout code
# git clone $GITHUB_WORKSPACE /workspace

# Configure AWS credentials
# aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
# aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
# aws configure set region $AWS_REGION

# # Login to ECR
# $(aws ecr get-login --no-include-email --region $AWS_REGION)

# # Get short SHA
# SHA8=$(echo ${GITHUB_SHA} | cut -c1-8)

# # Build, tag, and push image to ECR
# docker build -f /src/Dockerfile -t $ECR_REGISTRY/$ECR_REPOSITORY:$SHA8 /src
# docker push $ECR_REGISTRY/$ECR_REPOSITORY:$SHA8

# Deploy to EKS with Helm
# aws eks --region ${{ inputs.aws-region }} update-kubeconfig --name ${{ inputs.eks-cluster-name }}
# helm upgrade --install inventory-api-development ${{ inputs.helm-chart-path }} \
#   --namespace development \
#   --set image.repository=$ECR_REGISTRY/${{ inputs.ecr-repository }}:$SHA8,image.tag=latest

