A lightweight wallpaper switcher for Hyprland with smooth transition effects using awww.
VISUAL SELCTION: browse and select wallpapers using Rofi menu with thumnails preview
Prerequisites: 
INSTALL THESE THINGS
sudo pacman -S rofi imagemagick awww

SETUP
cp select-wallpaper.sh ~/.local/bin/
chmod +x ~/.local/bin/select-wallpaper.sh

HYPRLAND CONFIG FILE
nano ~/.connfig/hypr/hyprland.conf
# Start the wallpaper daemon
exec-once = awww-daemon

# Set the keybinding (e.g., SUPER + W)
bind = SUPER, W, exec, ~/.local/bin/select-wallpaper.sh

Then DOWNLOADS images and put them in Pictures/Wallpapers folder
