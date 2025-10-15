#!/bin/bash

# Williams Performance Friction - Font Update Deployment Script
# This script will deploy the Overpass font changes to your Contabo server

echo "🚀 Deploying Overpass font changes to wpfri.ca..."

# Server details
SERVER_HOST="wpfri.ca"
SERVER_USER="williams-pf"
APP_PATH="/opt/williams-pf/app"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Step 1: Uploading updated files...${NC}"

# Upload the CSS file
echo "📁 Uploading style.css..."
scp static/css/style.css ${SERVER_USER}@${SERVER_HOST}:${APP_PATH}/static/css/style.css
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ style.css uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload style.css${NC}"
    exit 1
fi

# Upload the HTML template
echo "📁 Uploading index.html..."
scp templates/index.html ${SERVER_USER}@${SERVER_HOST}:${APP_PATH}/templates/index.html
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ index.html uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload index.html${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 2: Restarting application services...${NC}"

# SSH into server and restart services
echo "🔄 Restarting application services..."
ssh ${SERVER_USER}@${SERVER_HOST} << 'EOF'
    echo "Stopping williams-performance-friction service..."
    sudo systemctl stop williams-performance-friction
    
    echo "Starting williams-performance-friction service..."
    sudo systemctl start williams-performance-friction
    
    echo "Reloading nginx..."
    sudo systemctl reload nginx
    
    echo "Checking service status..."
    sudo systemctl status williams-performance-friction --no-pager -l
    
    echo "Font deployment complete!"
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}🎉 Font deployment completed successfully!${NC}"
    echo -e "${GREEN}Your site at wpfri.ca should now be using the Overpass font.${NC}"
    echo -e "${YELLOW}Note: It may take a few minutes for changes to propagate.${NC}"
else
    echo -e "${RED}❌ Deployment failed. Please check the error messages above.${NC}"
    exit 1
fi

