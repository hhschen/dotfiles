# Vim Dotfiles

This repository contains my personal Vim configuration files (dotfiles). It includes all the settings, plugins, and custom scripts I've set up to enhance my productivity and editing efficiency. These configurations are for general purpose.

## Why Vim

Why not? I mean **WHY NOT**?

###  Why Vim and Not Neovim?

While **Neovim** is a great alternative to Vim, I still have a vim configuration:

- **Default on many OS**
- **Stability**
- **Minimalism**
- **Compatibility**
- **Familiarity**
- **Customizability**
- **Long-term Support**

## Installation

1. **Install Vim**

  You probably don't need to install vim. To check whether vim has been installed:
  ```bash
  which vim
  ```

  > [!IMPORTANT]
  > Require `fzf` for `fzf.vim`

2. **Link to correct path**

  ``` bash
  ln -s path/.vim ~/.vim
  ```

## Plugins
- vim-plug: plugin manager
- autopairs: Nothing but auto pairs bracket
- lightline: Minimal statusline
- vim-easycomplete: Minimalist autocomplete
- vim-vinegar: Better netrw
- vim-surround: Enhance coding experience
- vim-sneak: Better navigation
- vim-repeat: Enhance repeat `.`
- fzf: Fuzzy finder
