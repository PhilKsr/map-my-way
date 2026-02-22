# Pi Deployment Guide

This guide covers deploying Map My Way to a Raspberry Pi using Docker and Tailscale.

## Prerequisites

### On your Pi:
- Docker and Docker Compose installed
- Tailscale installed and authenticated
- Git installed
- Port 3000 available

### Setup Commands:
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo apt-get update
sudo apt-get install docker-compose-plugin

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# Clone repository
git clone https://github.com/PhilKsr/map-my-way.git
cd map-my-way
```

## Deployment

### Automatic Deployment
Run the deployment script:
```bash
./deployment/deploy.sh
```

### Manual Deployment
```bash
# Build and start services
docker-compose -f deployment/docker-compose.yml up -d --build

# Check logs
docker logs map-my-way -f

# Setup Tailscale serving
tailscale serve --bg --https=443 http://localhost:3000
```

## Configuration

### Environment Variables
Create a `.env` file in the deployment directory:
```bash
NODE_ENV=production
PORT=3000
```

### Tailscale Configuration
Update `docker-compose.yml` with your Tailscale hostname:
```yaml
labels:
  - "tailscale.serve=your-hostname.tailnet-name.ts.net:3000"
```

## Monitoring & Maintenance

### Watchtower Auto-Updates
The deployment includes Watchtower for automatic container updates:
- Checks for updates every 5 minutes
- Automatically pulls and restarts containers with new images
- Cleans up old images

### Manual Operations
```bash
# View logs
docker logs map-my-way -f

# Restart application
docker-compose -f deployment/docker-compose.yml restart

# Update application
git pull origin main
docker-compose -f deployment/docker-compose.yml up -d --build

# Stop application
docker-compose -f deployment/docker-compose.yml down

# Clean up
docker system prune -a
```

### Health Checks
- Local: http://localhost:3000
- Tailscale: https://your-hostname.tailnet-name.ts.net
- Container status: `docker ps`

## Troubleshooting

### Common Issues

1. **Container won't start**
   ```bash
   docker logs map-my-way
   docker-compose -f deployment/docker-compose.yml logs
   ```

2. **Port already in use**
   ```bash
   sudo lsof -i :3000
   sudo kill -9 <PID>
   ```

3. **Tailscale not working**
   ```bash
   tailscale status
   tailscale serve reset
   tailscale serve --bg --https=443 http://localhost:3000
   ```

4. **Out of disk space**
   ```bash
   docker system prune -a
   sudo apt autoremove
   ```

### Performance Tuning

For better Pi performance:
```bash
# Add to /boot/config.txt
gpu_mem=128
arm_64bit=1

# Increase swap if needed
sudo dphys-swapfile swapoff
sudo nano /etc/dphys-swapfile  # Set CONF_SWAPSIZE=2048
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
```