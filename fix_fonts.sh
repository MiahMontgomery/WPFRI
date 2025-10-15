#!/bin/bash

echo "🔧 FIXING YOUR FONT ISSUE NOW..."
echo "This will upload the Overpass font changes to wpfri.ca"
echo ""

# Upload CSS file
echo "📁 Uploading CSS file..."
scp static/css/style.css williams-pf@wpfri.ca:/opt/williams-pf/app/static/css/style.css

# Upload HTML file  
echo "📁 Uploading HTML file..."
scp templates/index.html williams-pf@wpfri.ca:/opt/williams-pf/app/templates/index.html

# Restart application
echo "🔄 Restarting your application..."
ssh williams-pf@wpfri.ca "sudo systemctl restart williams-performance-friction && sudo systemctl reload nginx"

echo ""
echo "✅ FONT FIX COMPLETE!"
echo "Your site should now use Overpass font instead of Rajdhani"
echo "Check wpfri.ca in a few minutes"


