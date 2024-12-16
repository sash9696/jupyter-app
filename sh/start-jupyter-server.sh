#!/usr/bin/env bash

# Copyright (c) Datalayer, Inc. https://datalayer.io
# Distributed under the terms of the MIT License.

echo -e "\x1b[34m\x1b[43mStarting Jupyter Server\x1b[0m"
echo
# Make sure the token environment variable is set
if [ -z "$JUPYTER_TOKEN" ]; then
    echo "Error: JUPYTER_TOKEN is not set!"
    exit 1
fi

echo ✨ open http://localhost:8686/api/jupyter?token=$JUPYTER_TOKEN
echo

# Set the current directory to where this script is located
export CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure the kill.sh and kill-jupyter-server.sh scripts are in the correct path
trap ${CURR_DIR}/sh/kill.sh EXIT

# Ensure the kill-jupyter-server.sh script is in the correct path
${CURR_DIR}/sh/kill-jupyter-server.sh

# Start the Jupyter server with the config file
jupyter server \
  --config=${CURR_DIR}/../config/jupyter_server_config.py \
  --ip=0.0.0.0 \
  --port=8686 \
  --allow-root
