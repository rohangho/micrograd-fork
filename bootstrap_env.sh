#!/usr/bin/env bash
set -euo pipefail

VENV_DIR=".venv-numpy1"
KERNEL_NAME="micrograd-np1"
DISPLAY_NAME="Python (micrograd-np1)"

if [ -d "$VENV_DIR" ]; then
  echo "Virtualenv $VENV_DIR already exists. Activate it with: source $VENV_DIR/bin/activate"
  exit 0
fi

# Find a python3
PYTHON=${PYTHON:-$(command -v python3 || command -v python || true)}
if [ -z "$PYTHON" ]; then
  echo "No python3 found on PATH. Install Python 3.10+ first." >&2
  exit 1
fi

echo "Creating venv at $VENV_DIR using $PYTHON"
"$PYTHON" -m venv "$VENV_DIR"
# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements.txt

# Register a Jupyter kernel for this venv (user-level)
python -m ipykernel install --user --name "$KERNEL_NAME" --display-name "$DISPLAY_NAME" --replace

echo
echo "Done. To use the environment:"
echo "  1) In your notebook UI, select kernel: $DISPLAY_NAME"
echo "  2) Or activate locally: source $VENV_DIR/bin/activate"
echo
echo "Note: To render Graphviz outputs you may also need the Graphviz 'dot' system package." 
echo "On macOS:  brew install graphviz"
