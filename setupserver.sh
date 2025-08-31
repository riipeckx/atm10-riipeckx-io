#!/bin/sh
set -eu
NEOFORGE_VERSION=21.1.203
# To use a specific Java runtime, set an environment variable named ATM10_JAVA to the full path of java.exe.
# To disable automatic restarts, set an environment variable named ATM10_RESTART to false.
# To install the pack without starting the server, set an environment variable named ATM10_INSTALL_ONLY to true.
ATM10_RESTART=false
ATM10_INSTALL_ONLY=true
INSTALLER="neoforge-$NEOFORGE_VERSION-installer.jar"
NEOFORGE_URL="https://maven.neoforged.net/releases/net/neoforged/neoforge/$NEOFORGE_VERSION/neoforge-$NEOFORGE_VERSION-installer.jar"

ATM10_VERSION=4.10
SERVERFILES_URL="https://mediafilez.forgecdn.net/files/6921/537/ServerFiles-4.10.zip"

pause() {
    printf "%s\n" "Press enter to continue..."
    read ans
}

if ! command -v "${ATM10_JAVA:-java}" >/dev/null 2>&1; then
    echo "Minecraft 1.21 requires Java 21 - Java not found"
    pause
    exit 1
fi

cd "$(dirname "$0")"
if [ ! -d libraries ]; then
    echo "Neoforge not installed, installing now."
    if [ ! -f "$INSTALLER" ]; then
        echo "No Neoforge installer found, downloading now."
        if command -v wget >/dev/null 2>&1; then
            echo "DEBUG: (wget) Downloading $NEOFORGE_URL"
            wget -O "$INSTALLER" "$NEOFORGE_URL"
        else
            if command -v curl >/dev/null 2>&1; then
                echo "DEBUG: (curl) Downloading $NEOFORGE_URL"
                curl -o "$INSTALLER" -L "$NEOFORGE_URL"
            else
                echo "Neither wget or curl were found on your system. Please install one and try again"
                pause
                exit 1
            fi
        fi
    fi

    echo "Running Neoforge installer."
    "${ATM10_JAVA:-java}" -jar "$INSTALLER" -installServer
fi

JAVA_VERSION=$("${ATM10_JAVA:-java}" -fullversion 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ ! "$JAVA_VERSION" -ge 21 ]; then
    echo "Minecraft 1.21 requires Java 21 - found Java $JAVA_VERSION"
    pause
    exit 1
fi

# Download $SERVERFILES if not present
if [ ! -f "ServerFiles-$ATM10_VERSION.zip" ]; then
    echo "No server files found, downloading now."
    if command -v wget >/dev/null 2>&1; then
        echo "DEBUG: (wget) Downloading $SERVERFILES_URL"
        wget -O "ServerFiles-$ATM10_VERSION.zip" "$SERVERFILES_URL"
    else
        if command -v curl >/dev/null 2>&1; then
            echo "DEBUG: (curl) Downloading $SERVERFILES_URL"
            curl -o "ServerFiles-$ATM10_VERSION.zip" -L "$SERVERFILES_URL"
        else
            echo "Neither wget or curl were found on your system. Please install one and try again"
            pause
            exit 1
        fi
    fi
    echo "Unzipping server files."
    if command -v unzip >/dev/null 2>&1; then
        unzip -o ServerFiles-$ATM10_VERSION.zip -x "config/*" -d .
        rm ServerFiles-$ATM10_VERSION.zip
    else
        echo "unzip not found on your system. Please install it and try again."
        pause
        exit 1
    fi
fi
