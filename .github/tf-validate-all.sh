#!/bin/bash

# Function to check if a folder contains a .tf file
contains_tf_file() {
  local folder="$1"
  if [ -n "$(find "$folder" -maxdepth 1 -type f -name '*.tf' -print -quit)" ]; then
    return 0  # Folder contains a .tf file
  else
    return 1  # Folder does not contain a .tf file
  fi
}

# Terraform Validate
terraform_validate() {
  local folder="$1"
  echo "Initializing Terraform in: $folder"
  (cd "$folder" && terraform init) || { echo "ERROR: Terraform init failed in $folder"; return 1; }

  echo "Validating Terraform in $folder"
  (cd "$folder" && terraform validate) || { echo "ERROR: Terraform validate failed in $folder"; return 1; }
}

# Recursive function to iterate through subfolders
iterate_subfolders() {
  local current_folder="$1"
  local error_flag=0

  for subfolder in "$current_folder"/*; do
    if [ -d "$subfolder" ]; then
      if contains_tf_file "$subfolder"; then
        terraform_validate "$subfolder" || error_flag=1
      fi
      iterate_subfolders "$subfolder" || error_flag=1
    fi
  done

  return "$error_flag"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <root_folder>"
  exit 1
fi

# Start iteration from the provided root folder
root_folder="$1"
if [ ! -d "$root_folder" ]; then
  echo "Error: The specified root folder does not exist."
  exit 1
fi

# Perform the iteration and check for errors
iterate_subfolders "$root_folder"
# Check the result of the function and exit accordingly
if [ $? -eq 1 ]; then
    exit 1
fi
exit 0