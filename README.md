# dotfiles

Personal configuration files.

## Project Structure

```text
.
├── .config
│   ├── Code/User       # VS Code
│   ├── alacritty       # Terminal 1
│   ├── fontconfig      # System font configuration
│   ├── foot            # Terminal 2 (Default)
│   ├── fuzzel          # Wayland runner & menu
│   ├── ghostty         # Terminal 3
│   ├── git             # git config
│   ├── mako            # Notification
│   ├── niri            # Window manager
│   ├── nvim            # Code editor 1
│   ├── swaylock        # Screen locker
│   ├── systemd/user    # Background services
│   ├── tmux            # Terminal multiplexer
│   ├── waybar          # System status bar
│   ├── yazi            # Terminal file manager
│   ├── zed             # Code editor 2
│   └── zsh             # Shell
├── .local
│   ├── bin             # Custom utility scripts
│   └── share           # Wallpapers and assets
├── LICENSE
├── README.md
└── insdot.sh           # Automatic install script (testing)
```

## Requirement

- Init System: `systemd`-based Linux distribution (RECOMMAND).
- Environment: Wayland-compatible compositor (like niri).
- Terminals: At least one of the included terminal emulators (foot, ghostty, or alacritty).
- Font:
   - Monospace: FiraCode Nerd Font
   - Interface: Inter
   - CJK Support: 文泉驛正黑體 (WenQuanYi Zen Hei)
- Neovim: `fzf`, `ripgrep`, `bat`, `tree-sitter-cli`


## Installation

### Automatic
The insdot.sh script is provided to automate the symlinking process.

``` bash
./insdot.sh
```

> [!CAUTION]
> `insdot.sh` is currently in testing. Use it at your own risk. It is highly recommended to review the script before execution.

### Manual

Alternatively, you can manually symlink specific directories:

Example:

```bash
ln -s ~/dotfiles/.config/niri ~/.config/niri
```

## License
WTFPL
