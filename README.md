🚀 Ubuntu Post-Install Automator

A streamlined Bash script to transform a fresh Ubuntu installation into a fully-functional workstation in minutes. This script is built for power users who prefer native performance—it prioritizes .deb packages, official repositories, and Nala over Snap packages.

📦 What’s in the Box?

This script automates the installation and configuration of the following:

🛠️ Core System & Package Management

    Nala: A faster, prettier, and more informative frontend for apt.

    Docker Engine: Includes docker.io and docker-compose (automatically adds your user to the docker group).

    Essential Tools: git, curl, wget, htop, zsh + Oh My zsh Framework and build-essential.

🌐 Browsers & Communication

    Browsers: Firefox (Native), Google Chrome, and Brave Browser.

    Chat: Discord (Native .deb) and Microsoft Teams (teams-for-linux community client).

📄 Productivity & Remote Work

    OnlyOffice: Complete desktop office suite (Desktop Editors).

    Remote Desktop: RustDesk and TeamViewer (Official repositories).

    Winboat: Official installation for winboat.app.

🎨 Desktop & Media (GNOME)

    VLC Media Player: The "play anything" media player.

    Extension Manager: A native tool to manage GNOME tweaks without a browser plugin.

    Automated Extensions:

        Clipboard Indicator: Searchable history of your copied items.

        Burn My Windows: Adds retro animations (fire, matrix, etc.) when closing windows.

        System Monitor (0ry0n): Real-time CPU/RAM/Network usage in your top bar.

🚀 Quick Start (One-Liner)

To set up a brand new machine, open your terminal and run:

    curl -sL https://raw.githubusercontent.com/khaiml/Ubuntu-Post-Install-Automator/main/setup-apps.sh | bash
Note: You will be prompted for your sudo password. Once the script finishes, please log out and log back in for the Docker permissions and GNOME extensions to initialize.

🛠️ How to Customize
Adding/Removing Standard Apps

The script uses a list for standard packages. Simply add or remove names from the APPS_TO_INSTALL array or the nala install block:
Bash

# Example: Adding GIMP
sudo nala install -y \
    vlc \
    gimp \
    ...

Adding New GNOME Extensions

If you want to add more extensions, find their ID on the GNOME Extensions website (the number in the URL) and add it to this line in the script:
Bash

gnome-extensions-cli install [EXTENSION_ID]

Modifying Standalone Apps

For apps like Chrome, Discord, or RustDesk, the script downloads the .deb file directly. If a link breaks due to a new version, update the wget URL in Section 3.
⚠️ Requirements

    OS: Ubuntu 22.04 LTS or newer.

    Architecture: x86_64.

    Privileges: Sudo access is required.

🤝 Contributing

Feel free to fork this repository and adapt it to your specific workflow!
