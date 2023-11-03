#!/bin/bash

# Ask the user to choose an option
# Display the options as a list
echo "Choose an option:"
echo "1. EC2"
echo "2. Lambda"
echo "3. S3"

# Prompt the user to choose an option
read -p "Enter the number of your choice: " option

# Specify the path where you want to create the JSON file based on the option
if [ "$option" = "1" ]; then
# Ask the user for input
  read -p "Enter instance name: " instance_name

  output_path="./modules/EC2/terraform.tfvars.json"

  content='terraform {
  source = "./modules/EC2"
}'

  terragrunt_output_path="terragrunt.hcl"

  # Write the content to the specified path
echo "$content" > "$terragrunt_output_path"

echo "terragrunt.hcl file created with the following content:"
cat "$terragrunt_output_path"

  # Create the JSON data using user input
json_data=$(cat <<EOF
{
  "instance_name": "$instance_name"
}
EOF
)

# Write the JSON data to the specified path
echo "$json_data" > "$output_path"

echo "Terraform var file created at $output_path with the following data:"
cat "$output_path"
else
  echo "Please choose an option."
fi
