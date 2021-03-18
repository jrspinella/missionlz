#!/bin/bash
#
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
#
# A series of prompts that creates a MLZ Configuration File

set -e

error_log() {
  echo "${1}" 1>&2;
}

usage() {
  echo "prompt_for_mlz_config.sh: A series of prompts that creates a MLZ Configuration File"
  error_log "usage: prompt_for_mlz_config.sh <output path>"
}

if [[ "$#" -gt 1 ]]; then
   usage
   exit 1
fi

output_path=${1:-"$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")/src/core"}

echo $output_path

read -p "Terraform Environment ('public', 'usgovernment', etc): " tf_environment
read -p "Name for this Mission LZ environment ('dev', 'test', etc): " mlz_env_name
read -p "Azure Tenant ID for this Mission LZ environment: " mlz_tenantid
read -p "Azure Region for Mission LZ configuration ('eastus', etc): " mlz_config_location
read -p "Azure Subscription ID for Mission LZ configuration: " mlz_config_subid
read -p "Azure Subscription ID for SACA Hub: " mlz_saca_subid
read -p "Azure Subscription ID for Tier 0: " mlz_tier0_subid
read -p "Azure Subscription ID for Tier 1: " mlz_tier1_subid
read -p "Azure Subscription ID for Tier 2: " mlz_tier2_subid

# generate a mlz_tf_cfg.var file
mlz_config_file="${output_path}/mlz_tf_cfg_generated.var"
rm -f "$mlz_config_file"
touch "$mlz_config_file"
{
    echo "tf_environment=${tf_environment}"
    echo "mlz_env_name=${mlz_env_name}"
    echo "mlz_config_location=${mlz_config_location}"
    echo "mlz_config_subid=${mlz_config_subid}"
    echo "mlz_tenantid=${mlz_tenantid}"
    echo "mlz_tier0_subid=${mlz_tier0_subid}"
    echo "mlz_tier1_subid=${mlz_tier1_subid}"
    echo "mlz_tier2_subid=${mlz_tier2_subid}"
    echo "mlz_saca_subid=${mlz_saca_subid}"
} >> "$mlz_config_file"