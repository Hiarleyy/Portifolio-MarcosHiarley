param (
    [string]$Username = "hiarley",
    [string]$Tag = "latest"
)

$ErrorActionPreference = "Stop"

$ImageName = "${Username}/portfolio:${Tag}"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Building & Pushing Portfolio Docker Image" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Image: $ImageName"
Write-Host "-----------------------------------------"

# Navigate to project root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($ScriptDir) {
    Set-Location "$ScriptDir\.."
}

# Check if Docker daemon is running
docker info > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker daemon is not running. Please start Docker first."
    exit 1
}

# Build image
Write-Host "Building the Docker image..." -ForegroundColor Yellow
docker build -f Dockerfile -t $ImageName .

# Push image
Write-Host "Pushing the Docker image to Docker Hub..." -ForegroundColor Yellow
Write-Host "Please make sure you are logged in to Docker Hub (run 'docker login' first)."
docker push $ImageName

Write-Host "-----------------------------------------"
Write-Host "Successfully pushed $ImageName!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
