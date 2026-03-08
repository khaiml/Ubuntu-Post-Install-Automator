#!/bin/bash

# --- 0. INSTALL NALA & GNOME TOOLS ---
echo "Installing Nala and Gnome Extension tools..."
sudo apt update && sudo apt install nala -y
sudo nala install -y gnome-shell-extension-manager pipx ca-certificates curl gnupg
pipx install gnome-extensions-cli --force

# Add pipx to path for this session
export PATH="$PATH:$HOME/.local/bin"

# --- 1. ADD EXTERNAL REPOSITORIES & KEYS ---
echo "Setting up repositories..."

# Docker Official Repository (Added)
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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
echo "Installing main apps, VLC, and Official Docker..."
# Swapped docker.io -> docker-ce
# Swapped docker-compose -> docker-compose-plugin
sudo nala install -y \
    firefox \
    brave-browser \
    onlyoffice-desktopeditors \
    teamviewer \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
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

# RustDesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb
sudo nala install ./rustdesk-1.3.7-x86_64.deb -y

# Microsoft Teams (Community Client)
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.4.15/teams-for-linux_1.4.15_amd64.deb
sudo nala install ./teams-for-linux_1.4.15_amd64.deb -y

# --- 4. WINBOAT INSTALLATION ---
curl -s https://winboat.app/install.sh | bash

# --- 5. GNOME EXTENSIONS ---
echo "Installing Gnome Extensions..."
gnome-extensions-cli install 779 4679 1689

# --- 6. POST-INSTALL ---
sudo usermod -aG docker $USER

# --- 7. ZSH & OH MY ZSH ---
echo "Installing Zsh and Oh My Zsh..."
sudo nala install -y zsh

# Install Oh My Zsh (Unattended mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Change default shell to Zsh for the current user
sudo chsh -s $(which zsh) $USER

# Update the .zshrc file to enable plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker)/' ~/.zshrc

echo "Installation complete! Please log out and back in to finish."
