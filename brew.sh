#!/bin/bash

# Script to install Homebrew packages from brew.txt

BREW_FILE="$(dirname "$0")/brew.txt"

# Check if brew.txt exists
if [ ! -f "$BREW_FILE" ]; then
    echo "Error: brew.txt not found at $BREW_FILE"
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed"
    echo "Install it from: https://brew.sh"
    exit 1
fi

echo "Reading packages from $BREW_FILE..."
echo ""

# Read each line from brew.txt
while IFS= read -r package || [ -n "$package" ]; do
    # Skip empty lines and comments (lines starting with #)
    if [[ -z "$package" || "$package" =~ ^[[:space:]]*# ]]; then
        continue
    fi

    # Trim whitespace
    package=$(echo "$package" | xargs)

    echo "Installing: $package"
    brew install "$package"

    if [ $? -eq 0 ]; then
        echo " Successfully installed $package"
    else
        echo " Failed to install $package"
    fi
    echo ""
done < "$BREW_FILE"

echo "Package installation complete!"
