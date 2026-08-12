#!/bin/bash

# Exit on error
set -e

# Default values
DEFAULT_USERNAME="hiarley"
DEFAULT_TAG="latest"

# Get Docker Hub username
DOCKERHUB_USERNAME=${1:-$DEFAULT_USERNAME}
TAG=${2:-$DEFAULT_TAG}
IMAGE_NAME="${DOCKERHUB_USERNAME}/portfolio:${TAG}"

echo "========================================="
echo " Building & Pushing Portfolio Docker Image"
echo "========================================="
echo "Image: ${IMAGE_NAME}"
echo "-----------------------------------------"

# Navigate to project root if run from bin directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Check if Docker daemon is running
if ! docker info > /dev/null 2>&1; then
  echo "Error: Docker daemon is not running. Please start Docker first."
  exit 1
fi

# Build image
echo "Building the Docker image..."
docker build -f Dockerfile -t "${IMAGE_NAME}" .

# Push image
echo "Pushing the Docker image to Docker Hub..."
echo "Please make sure you are logged in to Docker Hub (run 'docker login' first)."
docker push "${IMAGE_NAME}"

echo "-----------------------------------------"
echo "Successfully pushed ${IMAGE_NAME}!"
echo "========================================="
