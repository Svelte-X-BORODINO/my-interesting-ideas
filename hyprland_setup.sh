#!/bin/bash
# Minimal Hyprland Setup for Arch Linux

# --- Checks ---
[ "$(id -u)" -ne 0 ] && echo "Run with sudo!" && exit 1
grep -q "Arch Linux" /etc/os-release || { echo "For Arch Linux only!"; exit 1; }

# --- Paths ---
HYPR_DIR="$HOME/.config/hypr"
ALACRITTY_DIR="$HOME/.config/alacritty"

# --- Install Core Packages ---
echo "🚀 Installing core packages..."
sudo pacman -S --needed --noconfirm \
  hyprland alacritty waybar swaybg swaylock wofi \
  xdg-desktop-portal-hyprland noto-fonts

# --- GPU Drivers (auto-detect) ---
echo "🖥️ Installing GPU drivers..."
case $(lspci | grep -i vga | awk '{print $5}') in
  *Intel*) sudo pacman -S --noconfirm mesa vulkan-intel ;;
  *AMD*)   sudo pacman -S --noconfirm mesa vulkan-radeon ;;
  *NVIDIA*) sudo pacman -S --noconfirm nvidia nvidia-utils ;;
esac

# --- Hyprland Config ---
echo "⚙️ Creating Hyprland config..."
mkdir -p "$HYPR_DIR"
cat > "$HYPR_DIR/hyprland.conf" << 'EOF'
# Monitor setup
monitor=,preferred,auto,1

# Autostart
exec-once = waybar
exec-once = swaybg -c 000000  # Black background

# Input
input {
    kb_layout = us
    follow_mouse = 1
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    layout = dwindle
}

# Keybinds
$terminal = alacritty
$menu = wofi --show drun

bind = SUPER, Return, exec, $terminal
bind = SUPER, Q, killactive
bind = SUPER, Space, exec, $menu
EOF

# --- Alacritty Config ---
echo "🔧 Setting up Alacritty..."
mkdir -p "$ALACRITTY_DIR"
cat > "$ALACRITTY_DIR/alacritty.yml" << 'EOF'
window:
  decorations: none
font:
  size: 12.0
colors:
  primary:
    background: '#000000'
    foreground: '#ffffff'
EOF

# --- Waybar Config ---
echo "📊 Configuring Waybar..."
mkdir -p "$HOME/.config/waybar"
cat > "$HOME/.config/waybar/config" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "clock": {
        "format": "{:%H:%M}"
    }
}
EOF

echo "✅ Done! Reboot and select Hyprland."
echo "Keybinds:"
echo "SUPER + Enter: Alacritty"
echo "SUPER + Space: App launcher"
