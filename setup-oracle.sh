#!/bin/bash

# Oracle Cloud Deployment Setup Script for PulseCheck AI
# This script automates the deployment process on Oracle Cloud Free Tier

set -e

echo "🚀 Setting up PulseCheck AI on Oracle Cloud Free Tier..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu

# Install Docker Compose
echo "🔧 Installing Docker Compose..."
sudo apt install docker-compose-plugin -y

# Install Git
echo "📥 Installing Git..."
sudo apt install git -y

# Install Node.js 18
echo "📦 Installing Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Clone repository
echo "📥 Cloning PulseCheck AI repository..."
git clone https://github.com/hetanshpanigrahiofficial2006-ship-it/Diagnoverseai.git
cd Diagnoverseai/pulsecheck-ai-main

# Create environment file
echo "⚙️ Setting up environment variables..."
cp .env.example .env

# Add environment variables
cat >> .env << EOF

# Firebase Configuration
NEXT_PUBLIC_FIREBASE_API_KEY=AIzaSyBYHVp9GxWB3tOZeX86OVmo7cV6zyRbrcA
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=diagnoverseai.firebaseapp.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=diagnoverseai
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=diagnoverseai.firebasestorage.app
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=587946724360
NEXT_PUBLIC_FIREBASE_APP_ID=1:587946724360:web:59e58a62cca72681f6d5bd

# Google AI Configuration
GOOGLE_GENAI_API_KEY=AIzaSyArrn-pIVYDypJW0GQ96oHJTHq2yN-4rQ8

# Production Configuration
NEXT_TELEMETRY_DISABLED=1
NODE_ENV=production
PORT=3000
HOSTNAME=0.0.0.0
EOF

# Build and run application
echo "🏗️ Building and starting application..."
docker-compose up -d --build

# Wait for application to start
echo "⏳ Waiting for application to start..."
sleep 30

# Check application status
echo "🔍 Checking application status..."
docker-compose ps

# Get public IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "🌍 Your application is accessible at: http://$PUBLIC_IP:3000"

echo "✅ PulseCheck AI deployment complete!"
echo "📖 Check ORACLE_DEPLOYMENT.md for detailed instructions"
echo "🔧 Don't forget to update Firebase authorized domains with: $PUBLIC_IP"
