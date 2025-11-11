#!/bin/bash

# Initial Setup Script - Must be run as root
if [ "$EUID" -ne 0 ]; then
    echo -e "\033[91m	This installer must be run as root!!!!\033[0m"
    echo "	Please run with sudo!"
    exit 1
fi

# Create the audisu script in /bin
cat > /bin/audisu << 'EOL'
#!/bin/bash

# URL
DISCORD_URL="https://discord.com/api/download/stable?platform=linux"

# Detect distro and set package format
detect_format() {
    if grep -qiE "ubuntu|debian|pop|mint" /etc/*release*; then
        echo "deb"
    elif grep -qi "fedora" /etc/*release*; then
        echo "rpm"
    else
        echo "tar.gz"
    fi
}

# ASCII progress bar, lowk stolen from another repo
progress_bar() {
    local duration=${1}
    local columns=$(tput cols)
    local space=$(( columns - 2 ))
    
    for ((i=0; i<=space; i++)); do
        printf "\r["
        for ((j=0; j<i; j++)); do printf "▓"; done
        for ((k=i; k<space; k++)); do printf " "; done
        printf "]"
        sleep 0.02
    done
    echo
}

install_discord() {
    local FORMAT=$(detect_format)
    local PKG_EXT=".$FORMAT"
    local URL="${DISCORD_URL}&format=${FORMAT}"
    local FILENAME="discord-latest${PKG_EXT}"
    local TMP_DIR=$(mktemp -d)

    # Download with progress
    echo -e "\n\033[94mDownloading Discord (${FORMAT})...\033[0m"
    wget -q --show-progress -O "${TMP_DIR}/${FILENAME}" "${URL}" &
    progress_bar 2
        wait
    
    # Installs into temp directory
    echo -e "\n\033[93mInstalling package...\033[0m"
    if [ "${FORMAT}" = "deb" ]; then
        sudo dpkg -i "${TMP_DIR}/${FILENAME}" || sudo apt install -f -y
    elif [ "${FORMAT}" = "rpm" ]; then
        sudo rpm -i "${TMP_DIR}/${FILENAME}" || sudo dnf install -y "${TMP_DIR}/${FILENAME}"
    else
        sudo mkdir -p /opt/discord
        sudo tar -xzf "${TMP_DIR}/${FILENAME}" -C /opt/discord --strip-components=1
        sudo ln -sf /opt/discord/Discord /usr/bin/discord
    fi
    
    # THIS REMOVES THE DOWNLOADED PACKAGE FILE
    rm -rf "${TMP_DIR}"
    
    # HEREDOC FIXED (no indentation for ART)
    echo -e "\n\033[92m"
cat << 'ART'
			⠀⠀⢠⣴⣶⣿⣷⣤⣶⣤⣶⣾⣷⣶⣦⡄⠀⠀
			⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀
			⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀
			⣸⣿⣿⣿⡏⠀⠀⢹⣿⣿⡏⠀⠀⢹⣿⣿⣿⣇
			⣿⣿⣿⣿⣧⣀⣀⣼⣿⣿⣧⣀⣀⣼⣿⣿⣿⣿
			⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿
			⠈⠙⠛⠿⣿⠂⠀⠉⠉⠉⠉⠀⠐⣿⡿⠟⠋
	       Au      Dis        U
		  Auto   Discord   Updater
ART
    echo -e "\033[0m"
    echo -e "		\033[1mDiscord has been updated successfully!\033[0m\n"
}

install_discord
EOL

# set permissions
chmod 755 /bin/audisu
echo -e "	\033[92mSetup completed successfully!\033[0m"
echo "	You can now update Discord by typing: 'audisu'"
