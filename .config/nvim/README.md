# Neovim Configuration

> [!IMPORTANT]
> Starting from **Neovim 0.11.0** and above, `nvim-lspconfig` is **no longer required**. This setup uses Neovim’s built-in LSP API directly.

## 🌟 Overview

Welcome to my **Neovim configuration**! 🚀
This setup is designed for a **modern, efficient, and minimalist** development experience. With a strong focus on performance and usability, it delivers a **lightweight yet powerful** coding workflow.

The goal is to achieve a functional development environment using the **fewest plugins possible** — reducing bloat while maximizing productivity.

## ⚡ Performance

> [!NOTE]
> **Tested on:**
> - 2019 MacBook Pro 16" (Intel i9-9900HK)
> - ThinkPad X1 Carbon 6th Gen (Intel i7-8550U)

- **Startup Time**:
  - ~25–30ms (without opening files)
  - ~70–150ms (depending on file type and LSP startup)

## ✨ Features

- ⚡ **Optimized Performance** with Lazy Loading
- 🔥 **Fully Integrated LSP Support** (built-in Neovim LSP)
- 🛠 **Easy LSP Management** with `mason.nvim`
- 💜 **Syntax Highlighting & Code Parsing** via `nvim-treesitter`
- ✍ **Enhanced Editing Experience** (Auto-pairs, Commenting, Surround Editing)
- 📂 **Intuitive File Navigation** using `mini.files`
- 🎨 **Customizable Colorschemes** (Solarized Osaka, VSCode Theme)
- 🤝 **Efficient Statusline** powered by `lualine.nvim`
- 🎭 **Improved UI Feedback** with `noice.nvim`

## 🛠 Installation

### Prerequisites

- **Neovim 0.11+**
- **Git**
- Optional but recommended: `fzf`, `ripgrep (rg)`, `fd`

> [!WARNING]
> Do not install this configuration without reviewing the code first.  Proceed at your own risk if you choose not to verify it.

### 💽 Install & Run

1. Clone this repository:
   ```sh
   git clone https://github.com/azhhchen/.dotfiles ~/.config/nvim
   ```

2. Or run Neovim with a custom config path:
  ```sh
  NVIM_APPNAME=azhhchen/.dotfiles/.config/nvim nvim
  ```

## 🌐 Language Servers

Currently Configured:
- **Lua** — powered by `lua-language-server`
- **Rust** — powered by `rust-analyzer`

## ✒️ TODO

- [x] migrate to `blink.cmp`
- [x] Remove `nvim-lspconfig` and migrate to Neovim's built-in LSP API.
- [ ] Add `conform.nvim` and `nvim-lint`

## 📝 Notes & Contribution

If you have any issues or suggestions, feel free to open an **issue** or **pull request** on GitHub!

Happy coding! 🚀✨
