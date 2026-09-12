#!/bin/bash
# Install the Kiro CLI usage companion for Omarchy's agents bar widget.
set -euo pipefail

SRC_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

echo "==> Installing collector to ~/.local/bin"
mkdir -p "$HOME/.local/bin"
cp "$SRC_DIR/omarchy-agent-usage-kiro" "$HOME/.local/bin/omarchy-agent-usage-kiro"
chmod +x "$HOME/.local/bin/omarchy-agent-usage-kiro"

echo "==> Installing refresh timer"
mkdir -p "$HOME/.config/systemd/user"
cp "$SRC_DIR/systemd/omarchy-kiro-usage.service" "$SRC_DIR/systemd/omarchy-kiro-usage.timer" \
  "$HOME/.config/systemd/user/"
systemctl --user daemon-reload
systemctl --user enable --now omarchy-kiro-usage.timer
systemctl --user start omarchy-kiro-usage.service

echo "==> Installing Kiro brand mark into your agents widget copy"
if [[ ! -d $HOME/.config/omarchy/plugins/omarchy.agents ]]; then
  omarchy plugin clone omarchy.agents
fi
cp "$SRC_DIR/assets/kiro.svg" "$HOME/.config/omarchy/plugins/omarchy.agents/assets/kiro.svg"
omarchy-shell shell rescanPlugins || true

echo "Done. Open the agents widget in the bar — the Kiro CLI tab appears once"
echo "it has usage (run 'kiro-cli login' first if you have not)."
