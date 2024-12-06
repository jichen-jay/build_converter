#!/bin/bash

set -e  # Exit immediately if a command fails

if [[ "$(uname -m)" == "x86_64" && "$(uname -s)" == "Linux" && "$(python -V 2>&1 | cut -d' ' -f2 | cut -d '.' -f1,2)" == "3.11" ]]; then
      echo "Installing CPU-specific torch wheel..."
      uv pip install  https://download.pytorch.org/whl/cpu/torch-2.4.1%2Bcpu-cp311-cp311-linux_x86_64.whl
      uv pip install https://download.pytorch.org/whl/cpu/torchvision-0.19.1%2Bcpu-cp311-cp311-linux_x86_64.whl
      echo "Torch wheel installation complete."
else
      echo "System does not match the criteria for CPU-specific torch wheel."
       uv pip install "torch!=2.4.1+cpu"
       uv pip install "torchvision!=0.19.1+cpu"
   fi
