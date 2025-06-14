# VSCode settings
> [!IMPORTANT] 
> This is Visual Studio Code settings and keymappings.
You should put these files into the correct path.

For settings.json:
- macOS: ``$HOME/Library/Application\ Support/Code/User/settings.json``
- Windows: ``%APPDATA%\Code\User\settings.json``
- Linux: ``$HOME/Library/Application\ Support/Code/User/settings.json``\

For keybindings.json:
- macOS: ``$HOME/Library/Application\ Support/Code/User/keybindings.json``
- Windows: ``%APPDATA%\Code\User\keybindings.json``
- Linux: ``$HOME/Library/Application\ Support/Code/User/keybindings.json``

> [!TIP] 
> If you want to enable key repeat on macOS for VSCode + Vim, you need to execute the following command:

```zsh

# For VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# For VSCode Insiders
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false

# For VSCodium
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false

# To enable global key-repeat
# this is helpful if you're using Vim in a PWA like code-server
defaults write -g ApplePressAndHoldEnabled -bool false

```