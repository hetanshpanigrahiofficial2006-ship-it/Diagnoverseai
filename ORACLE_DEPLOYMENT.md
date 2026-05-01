# 🚀 Deploy PulseCheck AI to Oracle Cloud Free Tier

## 📋 Overview
Deploy your PulseCheck AI application to Oracle Cloud Infrastructure (OCI) Free Tier with always-free compute resources.

## 🌟 Oracle Cloud Free Tier Benefits
- ✅ **Always Free**: 4 ARM-based Ampere A1 cores with 24 GB RAM
- ✅ **4 Virtual Machines**: Up to 4 VMs with 1 OCPU and 1 GB RAM each
- ✅ **Block Storage**: 200 GB of block volume storage
- ✅ **Object Storage**: 10 GB of object storage
- ✅ **Load Balancer**: 1 load balancer with 10 Mbps bandwidth
- ✅ **Public IPs**: 2 public IPs
- ✅ **No credit card required** for free tier

## 🛠️ Step-by-Step Deployment

### **Step 1: Create Oracle Cloud Account**
1. Go to [cloud.oracle.com](https://cloud.oracle.com)
2. Click **"Start Free Trial"** or **"Sign Up"**
3. Fill in your details (no credit card for free tier)
4. Verify your email address
5. Sign in to OCI Console

### **Step 2: Set Up Compute Instance**
1. Navigate to **Compute** → **Instances**
2. Click **"Create Instance"**
3. Configure the instance:

#### **Basic Configuration**
- **Name**: `pulsecheck-ai-server`
- **Compartment**: Select your compartment
- **Availability Domain**: Choose any available domain

#### **Instance Configuration**
- **Instance Type**: **Virtual Machine**
- **Instance Shape**: **VM.Standard.A1.Flex** (Free Tier)
- **OCPU Count**: 4 (maximum for free tier)
- **Memory (GB)**: 24 (maximum for free tier)
- **Boot Volume Size**: 50 GB

#### **Image Configuration**
- **Operating System**: **Ubuntu** or **Oracle Linux**
- **Version**: Latest LTS (Ubuntu 22.04 recommended)
- **Boot Volume Type**: **Standard**

#### **Networking**
- **Virtual Cloud Network**: Create new VCN
- **Subnet**: Create new subnet
- **Assign Public IP**: **Yes**
- **Add SSH Keys**: Upload your public SSH key

### **Step 3: Configure Security**
1. Go to **Networking** → **Security Lists**
2. Add ingress rules:
   - **Port 22** (SSH) - Your IP only
   - **Port 80** (HTTP) - 0.0.0.0/0
   - **Port 443** (HTTPS) - 0.0.0.0/0
   - **Port 3000** (Next.js) - 0.0.0.0/0

### **Step 4: Connect to Instance**
```bash
ssh -i your-private-key.pem ubuntu@your-public-ip
```

### **Step 5: Install Docker & Docker Compose**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo apt install docker-compose-plugin -y

# Add user to docker group
sudo usermod -aG docker ubuntu

# Reboot to apply changes
sudo reboot
```

### **Step 6: Deploy Application**
```bash
# Clone repository
git clone https://github.com/hetanshpanigrahiofficial2006-ship-it/Diagnoverseai.git
cd Diagnoverseai/pulsecheck-ai-main

# Create environment file
cp .env.example .env

# Edit environment variables
nano .env
```

Add your environment variables:
```bash
# Firebase Configuration
NEXT_PUBLIC_FIREBASE_API_KEY=AIzaSyBYHVp9GxWB3tOZeX86OVmo7cV6zyRbrcA
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=diagnoverseai.firebaseapp.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=diagnoverseai
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=diagnoverseai.firebasestorage.app
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=587946724360
NEXT_PUBLIC_FIREBASE_APP_ID=1:587946724360:web:59e58a62cca72681f6d5bd

# Google AI Configuration
GOOGLE_GENAI_API_KEY=AIzaSyArrn-pIVYDypJW0GQ96oHJTHq2yN-4rQ8

# Additional Configuration
NEXT_TELEMETRY_DISABLED=1
NODE_ENV=production
```

### **Step 7: Run Application**
```bash
# Build and run with Docker Compose
docker-compose up -d

# Check logs
docker-compose logs -f

# Check status
docker-compose ps
```

### **Step 8: Set Up Domain (Optional)**
1. Go to **DNS** → **Zones**
2. Create DNS zone for your domain
3. Add A record pointing to your instance public IP
4. Configure SSL with Let's Encrypt

## 🔧 Advanced Configuration

### **Set Up Nginx Reverse Proxy**
Create `nginx/nginx.conf`:
```nginx
events {
    worker_connections 1024;
}

http {
    upstream pulsecheck_ai {
        server pulsecheck-ai:3000;
    }

    server {
        listen 80;
        server_name your-domain.com;

        location / {
            proxy_pass http://pulsecheck_ai;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

### **Set Up SSL with Certbot**
```bash
# Install certbot
sudo apt install certbot python3-certbot-nginx -y

# Get SSL certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

### **Set Up Monitoring**
```bash
# Install monitoring tools
sudo apt install htop iotop -y

# Check resource usage
htop
iotop
docker stats
```

## 🚀 Production Optimization

### **Performance Tuning**
1. **Enable Docker BuildKit**:
```bash
export DOCKER_BUILDKIT=1
```

2. **Optimize Docker Compose**:
```yaml
deploy:
  resources:
    limits:
      memory: 1.5G
      cpus: '0.5'
```

3. **Enable Swap Space**:
```bash
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### **Security Hardening**
1. **Configure Firewall**:
```bash
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw deny 3000  # Only allow through reverse proxy
```

2. **Set Up Fail2Ban**:
```bash
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
```

3. **Regular Updates**:
```bash
# Set up automatic security updates
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure unattended-upgrades
```

## 📊 Monitoring & Maintenance

### **Check Application Status**
```bash
# Docker containers
docker-compose ps

# Application logs
docker-compose logs pulsecheck-ai

# System resources
free -h
df -h
top
```

### **Backup Strategy**
```bash
# Create backup script
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
tar -czf /backup/pulsecheck-ai_$DATE.tar.gz /path/to/your/app
find /backup -name "pulsecheck-ai_*.tar.gz" -mtime +7 -delete
EOF

chmod +x backup.sh

# Add to crontab for daily backups
echo "0 2 * * * /path/to/backup.sh" | crontab -
```

### **Health Checks**
```bash
# Create health check script
cat > healthcheck.sh << 'EOF'
#!/bin/bash
if curl -f http://localhost:3000/api/health > /dev/null 2>&1; then
    echo "Application is healthy"
else
    echo "Application is down, restarting..."
    docker-compose restart pulsecheck-ai
fi
EOF

chmod +x healthcheck.sh

# Check every 5 minutes
echo "*/5 * * * * /path/to/healthcheck.sh" | crontab -
```

## 🌍 Access Your Application

After successful deployment:
- **Direct URL**: `http://your-public-ip:3000`
- **With Domain**: `http://your-domain.com`
- **HTTPS**: `https://your-domain.com` (after SSL setup)

## 💰 Cost Management

### **Free Tier Limits**
- **Compute**: 4 OCPU, 24 GB RAM total
- **Storage**: 200 GB block volume
- **Network**: 10 TB outbound data/month
- **Load Balancer**: 1 instance

### **Stay Within Free Tier**
- Monitor resource usage in OCI Console
- Set up billing alerts
- Use ARM-based instances (more efficient)
- Optimize Docker images for smaller size

## 🆘 Troubleshooting

### **Common Issues**
1. **Docker won't start**:
```bash
sudo systemctl restart docker
sudo usermod -aG docker ubuntu
```

2. **Port already in use**:
```bash
sudo lsof -i :3000
sudo kill -9 <PID>
```

3. **Memory issues**:
```bash
# Check memory usage
free -h
# Add swap space if needed
```

4. **Build failures**:
```bash
# Clear Docker cache
docker system prune -a
docker-compose down
docker-compose up --build
```

## 📞 Support

- **Oracle Cloud Documentation**: https://docs.oracle.com/en/cloud/
- **Community Forums**: https://community.oracle.com/
- **GitHub Issues**: https://github.com/hetanshpanigrahiofficial2006-ship-it/Diagnoverseai/issues

---

**🎉 Your PulseCheck AI is now running on Oracle Cloud Free Tier!**

Enjoy always-free hosting with enterprise-grade infrastructure! ☁️🚀
