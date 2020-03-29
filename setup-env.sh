#!/usr/bin/bash
# requirements: python3, pip3

KAGGLE_API_TOKEN=~/.kaggle/kaggle.json

echo "Create virtualenv..."
pip3 install virtualenv
virtualenv venv
source venv/bin/activate

echo "Setup environment..."
mkdir log

echo "Install kaggle..."
pip install kaggle

if test -f "$KAGGLE_API_TOKEN"; then
    echo "Kaggle API token file found!"
    chmod 600 ~/.kaggle/kaggle.json
    kaggle --version
else 
    echo "Error: Kaggle API token file not found!"
    echo "Please create a valid token file under $KAGGLE_API_TOKEN"
    echo "See: https://github.com/Kaggle/kaggle-api"
    exit 1
fi

echo "Configure cron..."
crontab -l | { cat; echo "* 3 * * * $(pwd)/download.sh >> $(pwd)/log/crontab.log 2>&1"; } | crontab -
echo "Done!"
