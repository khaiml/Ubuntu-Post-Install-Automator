🚀 Ubuntu Post-Install Automator

A streamlined bash script to transform a fresh Ubuntu installation into a fully-functional workstation in minutes. This script is designed to be Snap-free, prioritizing native .deb packages and official repositories.
📦 What’s in the Box?

This script automates the installation of the following tools:
🌐 Browsers & Communication

    Browsers: Firefox, Google Chrome, Brave Browser

    Chat: Discord, Microsoft Teams (teams-for-linux)

🛠️ Development & System

    Docker: docker.io & docker-compose (with automatic user group permissions)

    Package Management: Nala (A faster, prettier frontend for apt)

    Remote Desktop: RustDesk & TeamViewer

    Utilities: git, curl, wget, htop, build-essential

📄 Office & Tools

    OnlyOffice: Complete desktop office suite.

    Winboat: Official installation for winboat.app.

🚀 Quick Start (One-Liner)

Once you have uploaded your script to GitHub, you can run it on any fresh machine using this command:
Bash

curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO_NAME/main/setup.sh | bash

    Note: The script will prompt for your sudo password to install packages and add repositories.

🛠️ How to Customize
Adding "Standard" Apps (APT/Nala)

If the app is available in the standard Ubuntu repositories, simply find the APPS_TO_INSTALL list in the script and add the package name:
Bash

# Example: Adding VLC and GIMP
sudo nala install -y \
    vlc \
    gimp \
    ...

Adding Standalone .deb Files

For apps like Chrome or Discord that require a direct download, add a block in the Section 3 of the script:
Bash

# Template for new .deb apps:
wget -O app_name.deb "DIRECT_DOWNLOAD_URL"
sudo nala install ./app_name.deb -y

Removing Snaps

This script avoids Snaps by default. If you want to completely purge Snap from your system to save resources, you can add this line to the top of your script:
sudo apt purge snapd -y
⚠️ Requirements

    OS: Ubuntu 22.04 LTS or newer (tested on 24.04).

    Architecture: x86_64 (64-bit).

    Internet: Required to fetch repositories and .deb packages.

🤝 Contributing

Feel free to fork this repo, add your own personal tweaks, and submit a PR if you find a better way to automate the "Linux Desktop" experience!
