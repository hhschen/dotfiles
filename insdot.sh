#!/bin/sh

# ==============================================================================
# 1. 變數設定
# ==============================================================================
GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; RED='\033[0;31m'; NC='\033[0m'
DOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.cache/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
SYS_USER_DIR="$DOT_DIR/.config/systemd/user"

# 初始化
DO_ZSH=0; DO_DESKTOP=0; DO_FONTCFG=0
DO_ALACRITTY=0; DO_FOOT=0; DO_GHOSTTY=0
DO_NVIM=0; DO_ZED=0; DO_VSCODE=0
DO_GIT=0; DO_TMUX=0; DO_YAZI=0; DO_BIN=0; DO_SHARE=0
OTHER_SERVICES=""
RELOAD_SYSTEMD=0

# ==============================================================================
# 2. 工具函數
# ==============================================================================
ask() {
    printf "${CYAN}$1? [y/N]: ${NC}"
    read -r ans
    case "$ans" in [yY]*) return 0 ;; *) return 1 ;; esac
}

check_pkg() {
    _missing=""
    for _pkg in "$@"; do
        if ! pacman -Qi "$_pkg" >/dev/null 2>&1; then
            _missing="$_missing $_pkg"
        fi
    done

    if [ -n "$_missing" ]; then
        printf "${YELLOW}[缺失]${NC} 偵測到未安裝套件:%s\n" "$_missing"
        if ask "是否立即安裝"; then
            sudo pacman -S --needed $_missing
        fi
    fi
}

link_item() {
    src="$1"; target="$2"
    [ -e "$src" ] || return 0
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then return 0; fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/$(basename "$target")"
        printf "  ${YELLOW}[備份]${NC} %s\n" "$(basename "$target")"
    fi
    ln -sf "$src" "$target"
    printf "  ${GREEN}[連結]${NC} %s\n" "$(basename "$src")"
}

# ==============================================================================
# 3. 第一階段：收集意圖
# ==============================================================================
printf "${BLUE}==> [1/3] 配置選擇${NC}\n\n"

if ask "部署 Zsh 設定"; then DO_ZSH=1; fi

if ask "部署 Niri 桌面核心 (含 Niri/Waybar/Fuzzel/Mako/Swaylock 與核心服務)"; then
    DO_DESKTOP=1
    RELOAD_SYSTEMD=1
fi

# 其它 Systemd 服務
if [ -d "$SYS_USER_DIR" ]; then
    first_other=1
    for s_path in "$SYS_USER_DIR"/*; do
        [ -e "$s_path" ] || continue
        s_name=$(basename "$s_path")
        case "$s_name" in
            cliphist*|swaybg*|swayidle*|battery-notify*) continue ;;
            *)
                if [ "$first_other" = 1 ]; then
                    printf "\n${YELLOW}--- 其它 Systemd 服務 ---${NC}\n"
                    first_other=0
                fi
                if ask "部署服務: $s_name"; then
                    OTHER_SERVICES="$OTHER_SERVICES $s_name"
                    RELOAD_SYSTEMD=1
                fi
                ;;
        esac
    done
fi

printf "\n${YELLOW}--- 終端機模擬器 ---${NC}\n"
if ask "部署 Alacritty"; then DO_ALACRITTY=1; fi
if ask "部署 Foot";      then DO_FOOT=1; fi
if ask "部署 Ghostty";   then DO_GHOSTTY=1; fi

printf "\n${YELLOW}--- 程式編輯器 ---${NC}\n"
if ask "部署 Neovim";     then DO_NVIM=1; fi
if ask "部署 Zed";        then DO_ZED=1; fi
if ask "部署 VS Code";    then DO_VSCODE=1; fi

printf "\n${YELLOW}--- 通用工具與資源 ---${NC}\n"
if ask "部署 Fontconfig (含字體)";  then DO_FONTCFG=1; fi
if ask "部署 Git";                  then DO_GIT=1; fi
if ask "部署 Tmux";                 then DO_TMUX=1; fi
if ask "部署 Yazi";                 then DO_YAZI=1; fi
if ask "部署 .local/bin";           then DO_BIN=1; fi
if ask "部署 .local/share";         then DO_SHARE=1; fi

# ==============================================================================
# 4. 第二階段：確認
# ==============================================================================
printf "\n${YELLOW}確定啟動上述部署? [y/N]: ${NC}"
read -r confirm
case "$confirm" in [yY]*) ;; *) printf "取消退出\n"; exit 0 ;; esac

# ==============================================================================
# 5. 第三階段：執行
# ==============================================================================
printf "\n${BLUE}==> [3/3] 執行部署作業...${NC}\n"

# --- Zsh ---
if [ "$DO_ZSH" = 1 ]; then
    printf "${BLUE}:: 配置 Zsh...${NC}\n"
    check_pkg zsh eza fzf fd zoxide bat
    ZSHENV_SYS="/etc/zsh/zshenv"
    TARGET_VAL="$HOME/.config/zsh"
    if [ "$(/usr/bin/env zsh -c 'echo $ZDOTDIR' 2>/dev/null)" != "$TARGET_VAL" ]; then
        if ! [ -f "$ZSHENV_SYS" ] || ! grep -qF "ZDOTDIR=\"\$HOME/.config/zsh\"" "$ZSHENV_SYS"; then
            printf "  修改 %s (需要 sudo)...\n" "$ZSHENV_SYS"
            sudo mkdir -p /etc/zsh
            printf 'export ZDOTDIR="$HOME/.config/zsh"\n' | sudo tee -a "$ZSHENV_SYS" >/dev/null
        fi
    fi
    link_item "$DOT_DIR/.config/zsh" "$HOME/.config/zsh"
fi

# --- Niri 桌面核心 ---
if [ "$DO_DESKTOP" = 1 ]; then
    printf "${BLUE}:: 配置 Niri 桌面套件...${NC}\n"
    check_pkg niri waybar fuzzel mako swaylock cliphist swaybg swayidle
    for app in niri waybar fuzzel mako swaylock; do
        link_item "$DOT_DIR/.config/$app" "$HOME/.config/$app"
    done
    mkdir -p "$HOME/.config/systemd/user"
    for svc in cliphist swaybg swayidle battery-notify; do
        if [ -f "$SYS_USER_DIR/$svc.service" ]; then
            link_item "$SYS_USER_DIR/$svc.service" "$HOME/.config/systemd/user/$svc.service"
        elif [ -d "$SYS_USER_DIR/$svc" ]; then
            link_item "$SYS_USER_DIR/$svc" "$HOME/.config/systemd/user/$svc"
        fi
    done
fi

# --- 處理其它選中的服務 ---
for s in $OTHER_SERVICES; do
    link_item "$SYS_USER_DIR/$s" "$HOME/.config/systemd/user/$s"
done

# --- 其餘工具 ---
[ "$DO_FONTCFG" = 1 ]   && check_pkg inter-font wqy-microhei ttf-firacode-nerd && link_item "$DOT_DIR/.config/fontconfig" "$HOME/.config/fontconfig"
[ "$DO_ALACRITTY" = 1 ] && check_pkg alacritty                                 && link_item "$DOT_DIR/.config/alacritty"  "$HOME/.config/alacritty"
[ "$DO_FOOT" = 1 ]      && check_pkg foot                                      && link_item "$DOT_DIR/.config/foot"       "$HOME/.config/foot"
[ "$DO_GHOSTTY" = 1 ]   && check_pkg ghostty                                   && link_item "$DOT_DIR/.config/ghostty"    "$HOME/.config/ghostty"
[ "$DO_NVIM" = 1 ]      && check_pkg neovim tree-sitter-cli rg fd              && link_item "$DOT_DIR/.config/nvim"       "$HOME/.config/nvim"
[ "$DO_ZED" = 1 ]       && check_pkg zed                                       && link_item "$DOT_DIR/.config/zed"        "$HOME/.config/zed"
[ "$DO_VSCODE" = 1 ]    && check_pkg code                                      && link_item "$DOT_DIR/.config/Code/User" "$HOME/.config/Code/User"
[ "$DO_GIT" = 1 ]       && check_pkg git                                       && link_item "$DOT_DIR/.config/git"        "$HOME/.config/git"
[ "$DO_TMUX" = 1 ]      && check_pkg tmux                                      && link_item "$DOT_DIR/.config/tmux"       "$HOME/.config/tmux"
[ "$DO_YAZI" = 1 ]      && check_pkg yazi                                      && link_item "$DOT_DIR/.config/yazi"       "$HOME/.config/yazi"

# --- 處理 .local ---
if [ "$DO_BIN" = 1 ]; then
    mkdir -p "$HOME/.local/bin"
    for f in "$DOT_DIR/.local/bin/"*; do
        if [ -e "$f" ]; then link_item "$f" "$HOME/.local/bin/$(basename "$f")"; chmod +x "$f"; fi
    done
fi

if [ "$DO_SHARE" = 1 ]; then
    mkdir -p "$HOME/.local/share"
    for d in "$DOT_DIR/.local/share/"*; do [ -e "$d" ] && link_item "$d" "$HOME/.local/share/$(basename "$d")"; done
fi

# --- 結尾：Systemd 重載 ---
if [ "$RELOAD_SYSTEMD" = 1 ]; then
    printf "\n${BLUE}:: 執行 systemd daemon reload...${NC}\n"
    systemctl --user daemon-reload
fi

printf "\n${GREEN}==> 部署完成！${NC}\n"
