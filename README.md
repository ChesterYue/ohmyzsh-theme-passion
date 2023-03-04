# ohmyzsh-theme-passion

An oh-my-zsh theme.

## Introduction

![passion](https://raw.githubusercontent.com/ChesterYue/ohmyzsh-theme-passion/master/passion.gif)

* real time prompt.
* command running time cost prompt.
* command running error hint.

## Usage

1. clone repo: ```git clone https://github.com/ChesterYue/ohmyzsh-theme-passion```;
2. copy theme: ```cp ./ohmyzsh-theme-passion/passion.zsh-theme ~/.oh-my-zsh/themes/passion.zsh-theme```;
3. modify config: open ```~/.zshrc``` edit to ```ZSH_THEME="passion"```;
4. execute rc: ```source ~./zshrc```;

REF: [Overriding and adding themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes)

## Trouble Shooting

### macOS

passion.zsh-theme depends on cmd ```gdate``` to get current time in milliseconds which is not installed by default in macOS.

to get ```gdate``` by running ```brew install coreutils;```
