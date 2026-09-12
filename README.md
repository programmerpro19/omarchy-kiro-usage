# Kiro CLI usage for Omarchy's agents widget

Shows Kiro CLI token usage and credit-quota limits in the Omarchy bar's agents widget, next to Claude Code and Codex.

> **Upstream:** this is proposed for inclusion in Omarchy itself — follow and +1 https://github.com/omacom/omarchy/pull/11557. Once that merges, this repo is obsolete: `omarchy update` will ship the collector and you can uninstall this.

## What it does

- `omarchy-agent-usage-kiro` collects local token stats from `~/.kiro/sessions/cli/` session sidecars plus the credit pool from `AmazonCodeWhispererService.GetUsageLimits` (the same call kiro-cli's own `/usage` makes), and prints the JSON record the agents panel reads.
- A systemd user timer refreshes `~/.local/state/omarchy/agents/usage/kiro.json` every 15 minutes.
- The official Kiro ghost mark (from `@lobehub/icons`, MIT) is installed into your cloned `omarchy.agents` widget copy.

## Install

```bash
git clone <this-repo> && cd omarchy-kiro-usage && ./install.sh
```

Requires: Omarchy, `kiro-cli` logged in (`kiro-cli login`).

## Uninstall

```bash
systemctl --user disable --now omarchy-kiro-usage.timer
rm ~/.local/bin/omarchy-agent-usage-kiro \
  ~/.local/state/omarchy/agents/usage/kiro.json \
  ~/.config/systemd/user/omarchy-kiro-usage.{service,timer} \
  ~/.config/omarchy/plugins/omarchy.agents/assets/kiro.svg
omarchy-shell shell rescanPlugins
```
