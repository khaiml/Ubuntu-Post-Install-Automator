#!/bin/bash

# --- 0. INSTALL NALA & GNOME TOOLS ---
echo "Installing Nala and Gnome Extension tools..."
sudo apt update && sudo apt install nala -y
sudo nala install -y gnome-shell-extension-manager pipx
pipx install gnome-extensions-cli --force

# Add pipx to path for this session
export PATH="$PATH:$HOME/.local/bin"

# --- 1. ADD EXTERNAL REPOSITORIES & KEYS ---
echo "Setting up repositories..."

# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# OnlyOffice
sudo curl -fsSL https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE | sudo gpg --dearmor -o /usr/share/keyrings/onlyoffice.gpg
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list

# TeamViewer
curl -fsSL https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo gpg --dearmor -o /usr/share/keyrings/teamviewer.gpg
echo "deb [signed-by=/usr/share/keyrings/teamviewer.gpg] http://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list

sudo nala update

# --- 2. INSTALL VIA REPOSITORY ---
echo "Installing main apps and VLC..."
sudo nala install -y \
    firefox \
    brave-browser \
    onlyoffice-desktopeditors \
    teamviewer \
    docker.io \
    docker-compose \
    vlc \
    wget \
    git

# --- 3. DOWNLOAD & INSTALL .DEB FILES ---
mkdir -p ~/Downloads/deb_apps && cd ~/Downloads/deb_apps

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo nala install ./google-chrome-stable_current_amd64.deb -y

# Discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo nala install ./discord.deb -y

# RustDesk (Updated to 1.3.7 - adjust if link breaks)
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb
sudo nala install ./rustdesk-1.3.7-x86_64.deb -y

# Microsoft Teams (Community Client)
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.4.15/teams-for-linux_1.4.15_amd64.deb
sudo nala install ./teams-for-linux_1.4.15_amd64.deb -y

# --- 4. WINBOAT INSTALLATION ---
curl -s https://winboat.app/install.sh | bash

# --- 5. GNOME EXTENSIONS ---
echo "Installing Gnome Extensions..."
# IDs: Clipboard (779), Burn My Windows (4679), Resource Monitor (0ry0n is 1689)
gnome-extensions-cli install 779 4679 1689

# --- 6. POST-INSTALL ---
sudo usermod -aG docker $USER

echo "Installation complete! Please log out and back in to finish."
