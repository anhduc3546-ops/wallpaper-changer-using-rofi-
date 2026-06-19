#!/usr/bin/env zsh

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="/tmp/rofi_wall_cache"
mkdir -p "$CACHE_DIR"

# 1. Tạo thumbnail
for img in "$WALL_DIR"/*.(jpg|jpeg|png|webp); do
    [[ -e "$img" ]] || continue
    name=$(basename "$img")
    if [[ ! -f "$CACHE_DIR/$name" ]]; then
        magick "$img" -resize 300x169^ -gravity center -extent 300x169 "$CACHE_DIR/$name"
    fi
done

# 2. Tạo danh sách cho Rofi
menu_list=""
for img in "$WALL_DIR"/*.(jpg|jpeg|png|webp); do
    [[ -e "$img" ]] || continue
    name=$(basename "$img")
    menu_list+="${name}\0icon\x1f${CACHE_DIR}/${name}\n"
done

# 3. Gọi Rofi (Đã sửa lại dấu ngoặc cho đúng)
selected=$(printf "$menu_list" | rofi -dmenu -show-icons -theme ~/.config/rofi/wallpaper-selector.rasi)

# 4. Áp dụng thay đổi
if [[ -n "$selected" ]]; then
    # Kiểm tra daemon trước khi đổi ảnh
    if ! pgrep -x "awww-daemon" > /dev/null; then
        awww-daemon &
        sleep 1
    fi
    
    # Lệnh awww chuẩn xác với gạch chéo xuống dòng
    awww img "$WALL_DIR/$selected" \
        --transition-type random \
        --transition-duration 2.0
fi
