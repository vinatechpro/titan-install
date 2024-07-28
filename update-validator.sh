#!/bin/bash

# Define constants
TITAN_DIR=~/.titan
BACKUP_DIR=~/titan-test-1-config
TITAND_URL="https://laodau.sgp1.cdn.digitaloceanspaces.com/titan-network/validator/titand"
TITAND_PATH=/usr/local/bin/titand

# Step 1: Backup keys
echo "Backing up keys..."
rsync -av --exclude "data" $TITAN_DIR $BACKUP_DIR
if [ $? -ne 0 ]; then
    echo "Backup failed. Exiting..."
    exit 1
fi

# Step 2: Convert and backup Titan data
echo "Converting and backing up Titan data..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Titannet-dao/titan-chain/main/scripts/update.sh)"
if [ $? -ne 0 ]; then
    echo "Data conversion and backup failed. Exiting..."
    exit 1
fi

# Step 3: Download the titand executable
echo "Downloading titand executable..."
curl -o titand $TITAND_URL
if [ $? -ne 0 ]; then
    echo "Download failed. Exiting..."
    exit 1
fi

# Step 4: Make the downloaded titand executable
chmod +x titand

# Step 5: Move the built executable to the system path
echo "Moving titand to system path..."
sudo cp titand $TITAND_PATH
if [ $? -ne 0 ]; then
    echo "Failed to move titand to system path. Exiting..."
    exit 1
fi

# Step 6: Start the Titan program
echo "Starting Titan program..."
sudo systemctl start titan
if [ $? -ne 0 ]; then
    echo "Failed to start Titan program. Exiting..."
    exit 1
fi

# Wait for 3 seconds
echo "Waiting for 3 seconds..."
sleep 3

# Check the status of the Titan program
echo "Checking the status of the Titan program..."
sudo systemctl status titan

echo "Titan validator update completed successfully."
