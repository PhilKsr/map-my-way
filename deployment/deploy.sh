#!/bin/bash

# Pi Deployment Script for Map My Way
# This script automates deployment to Raspberry Pi with Tailscale integration

set -e

# Configuration
PROJECT_NAME="map-my-way"
DOCKER_IMAGE="$PROJECT_NAME:latest"
CONTAINER_NAME="$PROJECT_NAME"
TAILSCALE_HOSTNAME="map-my-way"

echo "🚀 Starting Map My Way deployment to Pi..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if Tailscale is running
if ! tailscale status >/dev/null 2>&1; then
    echo "❌ Tailscale is not running. Please start Tailscale first."
    exit 1
fi

# Pull latest code from GitHub
echo "📥 Pulling latest code from GitHub..."
git pull origin main

# Stop and remove existing container
echo "🛑 Stopping existing container..."
docker-compose -f deployment/docker-compose.yml down || true

# Build new image
echo "🔨 Building Docker image..."
docker build -f deployment/Dockerfile -t $DOCKER_IMAGE .

# Start services
echo "🚀 Starting services..."
docker-compose -f deployment/docker-compose.yml up -d

# Wait for container to be healthy
echo "⏳ Waiting for container to start..."
sleep 10

# Check if container is running
if docker ps | grep -q $CONTAINER_NAME; then
    echo "✅ Container is running successfully!"
else
    echo "❌ Container failed to start. Checking logs..."
    docker logs $CONTAINER_NAME
    exit 1
fi

# Setup Tailscale serving (if not already configured)
echo "🌐 Setting up Tailscale serving..."
tailscale serve --bg --https=443 --set-path=/health http://localhost:3000/health || true
tailscale serve --bg --https=443 http://localhost:3000 || true

echo "🎉 Deployment complete!"
echo "📍 Your application should be available at:"
echo "   - Local: http://localhost:3000"
echo "   - Tailscale: https://$TAILSCALE_HOSTNAME.tailnet-name.ts.net"

echo "📊 To check logs: docker logs $CONTAINER_NAME -f"
echo "🔄 To restart: docker-compose -f deployment/docker-compose.yml restart"