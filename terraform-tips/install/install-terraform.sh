#!/bin/bash

# **********************************************************
# This script will install the latest version of Terraform and
# supports both Linux and macOS, on both AMD64 and ARM hardware
# platforms. Run the script and it will determine your platform
# automatically, download the latest release version of HashiCorp
# Terraform, and install it in the '/usr/local/bin' folder so you
# can run 'terraform' locally.
#
# Original Source:
# https://github.com/Build5Nines/terraform-quickstart-templates/blob/main/terraform-tips/install/install-terraform.sh
#
# Copyright (c) 2024 Build5Nines LLC (https://build5nines.com)
# License: MIT License (https://github.com/Build5Nines/terraform-quickstart-templates/blob/main/LICENSE)
# **********************************************************

set -e

to_lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Function to get all available Terraform versions
get_available_versions() {
    echo "Retreiving available Terraform versions..."
    if [[ $(uname) == "Darwin" ]]; then
        curl -s https://releases.hashicorp.com/terraform/ | grep -oE 'terraform_[^<]+' | cut -d '_' -f 2 | sort -V
    else
        curl -s https://releases.hashicorp.com/terraform/ | grep -oP 'terraform_[^<]+' | cut -d '_' -f 2 | sort -V
    fi
}

get_architecture() {
    if [[ $(uname -m) == "x86_64" ]]; then
        echo "$(uname)_amd64"
    else
        echo "$(uname)_arm64"
    fi
}

available_versions=$(get_available_versions)

# Filter out alpha and beta versions
filtered_versions=$(echo "$available_versions" | grep -v -E 'alpha|beta|rc')

# Get the most recent stable version
latest_version=$(echo "$filtered_versions" | tail -n 1)

architecture=$(to_lowercase "$(get_architecture)")

echo "Downloading latest Terraform version (v$latest_version) for $architecture..."
download_url=https://releases.hashicorp.com/terraform/${latest_version}/terraform_${latest_version}_${architecture}.zip
#download_url=$(to_lowercase "$download_url")
# echo $download_url

output_dir=/usr/local/bin
output_zip=${output_dir}/terraform_${latest_version}_${architecture}.zip

curl ${download_url} -o ${output_zip}

unzip "${output_zip}" -d ${output_dir} -o

rm ${output_zip}

echo "Terraform v$latest_version has been installed."

