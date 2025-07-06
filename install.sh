# 检查是否安装了 kdotool
if ! command -v kdotool &>/dev/null; then
    echo "❌ kdotool 未安装，正在安装 ..."

    # 检测操作系统类型
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO_FAMILY=${ID_LIKE,,}
    else
        echo "❌ 无法识别操作系统（缺少 /etc/os-release）"
        exit 1
    fi

    # 安装依赖
    echo "🔍 正在安装依赖 kdotool ..."

    if command -v pacman &>/dev/null; then
        echo "📦 使用 pacman 安装"
        sudo pacman -Sy --noconfirm kdotool
    elif command -v apt &>/dev/null; then
        echo "📦 使用 apt 安装"
        sudo apt update
        sudo apt install -y kdotool
    elif command -v dnf &>/dev/null; then
        echo "📦 使用 dnf 安装"
        sudo dnf makecache
        sudo dnf install -y kdotool
    elif command -v zypper &>/dev/null; then
        echo "📦 使用 zypper 安装"
        sudo zypper refresh
        sudo zypper install -y kdotool
    else
        echo "❌ 未识别的包管理器，请手动安装 kdotool"
        exit 1
    fi
else
    echo "✅ kdotool 已经安装，继续进行后续操作。"
fi

# 提示用户输入浏览器窗口名
read -rp "请输入浏览器窗口标题关键词（用于窗口激活，例如 Firefox、LibreWolf、Chromium 等，默认 Firefox）: " TARGET_APP_NAME

# 如果用户直接回车，使用默认值
if [[ -z "$TARGET_APP_NAME" ]]; then
    TARGET_APP_NAME="Firefox"
    echo "未输入，使用默认值：$TARGET_APP_NAME"
else
    echo "将使用输入的窗口名：$TARGET_APP_NAME"
fi

# 替换 xdg-open 脚本中的 "Firefox"（注意要先存在原始的 "Firefox" 字样）
sed -i "s/\"Firefox\"/\"$TARGET_APP_NAME\"/g" ./xdg-open

sudo cp ./xdg-open /usr/local/bin/xdg-open
sudo chmod +x /usr/local/bin/xdg-open
