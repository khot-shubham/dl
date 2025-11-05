#!/usr/bin/env bash

# Exit if any command fails
set -e

ENV_NAME="mydlvenv"
PYTHON_VERSION="python3"  # Can be python3.10 if needed

echo "### Creating virtual environment: $ENV_NAME ###"

# Create virtual environment
$PYTHON_VERSION -m venv $ENV_NAME

# Activate virtual environment
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    source "$ENV_NAME/Scripts/activate"
else
    source "$ENV_NAME/bin/activate"
fi

# Upgrade pip
pip install --upgrade pip

# Install TensorFlow (CPU)
echo "Installing TensorFlow..."
pip install tensorflow

# Install PyTorch (CPU version)
echo "Installing PyTorch..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install Jupyter Notebook
echo "Installing Jupyter Notebook..."
pip install notebook ipykernel

# Create kernel for Jupyter
python -m ipykernel install --user --name=$ENV_NAME --display-name "Python ($ENV_NAME)"

# Install extra libraries
pip install numpy pandas matplotlib scikit-learn

echo "### Setup Complete! ###"
echo "Activate environment with:"
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    echo "source $ENV_NAME/Scripts/activate"
else
    echo "source $ENV_NAME/bin/activate"
fi
echo "Run Jupyter Notebook with: jupyter notebook"
