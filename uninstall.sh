#!/bin/bash

# 删除脚本文件
sudo rm -f /usr/local/bin/xdg-open
echo "🗑️ 已删除 /usr/local/bin/xdg-open"

# 提示用户是否卸载依赖
read -p "是否要卸载依赖 (kdotool)? [y/N]: " UNINSTALL_DEPS

# 如果用户选择卸载
if [[ "$UNINSTALL_DEPS" =~ ^[Yy]$ ]]; then
    if command -v pacman &>/dev/null; then
        sudo pacman -Rns --noconfirm kdotool
    elif command -v apt &>/dev/null; then
        sudo apt remove --purge -y kdotool
    elif command -v dnf &>/dev/null; then
        sudo dnf remove -y kdotool
    elif command -v zypper &>/dev/null; then
        sudo zypper remove -y kdotool
    else
        echo "❌ 未识别的包管理器，无法卸载 kdotool"
    fi
else
    echo "✅ 已保留依赖。"
fi

echo "✅ 卸载完成！"
