#!/bin/bash
# Double-click this file to start the Rocwell ACQ Dashboard
cd "$(dirname "$0")"
echo "Starting Rocwell ACQ Dashboard..."
echo "Opening http://localhost:8765"
sleep 1
open http://localhost:8765
python3 -m http.server 8765
