set -e
DEPLOYMENT_FILE="./kubernetes/deployment.yaml"

if [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
    ECR_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/gabapprepoprod:latest"
    echo "Deploying to production environment..."
else
    ECR_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/gabapprepodev:latest"
    echo "Deploying to development environment..."
fi

if [[ ! -f "$DEPLOYMENT_FILE" ]]; then
    echo "Error: Deployment file $DEPLOYMENT_FILE does not exist."
    exit 1
fi

sed -i.bak "s|image: \".*\"|image: \"$ECR_IMAGE\"|" "$DEPLOYMENT_FILE"

echo "Updated $DEPLOYMENT_FILE with image: $ECR_IMAGE"