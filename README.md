# ohmyzsh-theme-passion
An oh-my-zsh theme.

## Introducion
![passion](https://raw.githubusercontent.com/ChesterYue/ohmyzsh-theme-passion/master/passion.gif)

* time prompt will update once you finish inputting.
* time cost will show after command running.

## Usage
REF: [Oh-My-Zsh External themes](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes)

### Trouble Shooting

#### macOS
passsion.zsh-theme uses cmd ```gdate``` to get current time in milliseconds which is not installed default in macOS.

run ```brew install coreutils;``` to get ```gdate```;