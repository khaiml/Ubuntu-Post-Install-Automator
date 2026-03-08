#!/bin/bash

# --- 0. INSTALL NALA FIRST ---
echo "Installing Nala for a better experience..."
sudo apt update && sudo apt install nala -y

# --- 1. ADD EXTERNAL REPOSITORIES & KEYS ---
echo "Setting up repositories for Chrome, Brave, Discord, and others..."

# Brave Browser
sudo nala install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# OnlyOffice
sudo curl -fsSL https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE | sudo gpg --dearmor -o /usr/share/keyrings/onlyoffice.gpg
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list

# TeamViewer
curl -fsSL https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo gpg --dearmor -o /usr/share/keyrings/teamviewer.gpg
echo "deb [signed-by=/usr/share/keyrings/teamviewer.gpg] http://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list

# Update everything after adding new sources
sudo nala update

# --- 2. INSTALL VIA REPOSITORY ---
echo "Installing apps via Nala..."
sudo nala install -y \
    firefox \
    brave-browser \
    onlyoffice-desktopeditors \
    teamviewer \
    docker.io \
    docker-compose \
    wget

# --- 3. DOWNLOAD & INSTALL .DEB FILES (Chrome, Discord, RustDesk) ---
# Some apps don't have stable repos, so we grab the latest installer file directly.
echo "Downloading and installing standalone .deb packages..."

mkdir -p ~/Downloads/deb_apps && cd ~/Downloads/deb_apps

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo nala install ./google-chrome-stable_current_amd64.deb -y

# Discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo nala install ./discord.deb -y

# RustDesk
# Note: RustDesk versions change often; this grabs the latest 1.2.3 as an example. 
# Check their GitHub if this link breaks.
wget https://github.com/rustdesk/rustdesk/releases/download/1.2.3/rustdesk-1.2.3-x86_64.deb
sudo nala install ./rustdesk-1.2.3-x86_64.deb -y

# Microsoft Teams (PWA/Web version is recommended, but here is the official client/insider)
# Note: Microsoft retired the dedicated Linux app for a PWA, but many use the 'teams-for-linux' community client.
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.4.15/teams-for-linux_1.4.15_amd64.deb
sudo nala install ./teams-for-linux_1.4.15_amd64.deb -y

# --- 4. WINBOAT INSTALLATION ---
echo "Installing Winboat..."
curl -s https://winboat.app/install.sh | bash

# --- 5. POST-INSTALL (Docker Setup) ---
echo "Setting up Docker permissions..."
sudo usermod -aG docker $USER

echo "------------------------------------------------"
echo "INSTALLATION COMPLETE!"
echo "Note: You may need to log out and back in for Docker permissions to take effect."
echo "------------------------------------------------"
