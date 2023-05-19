# ohmyzsh-theme-passion

## Introduction

An oh-my-zsh theme;
![demo.png](./demo/demo.png)

### Feature

* real time prompt;
* command running time cost prompt;
* command running error hint;
* git status prompt;

## Usage

### Basic Zsh Theme

#### Install

1. clone repo: ```git clone https://github.com/ChesterYue/ohmyzsh-theme-passion```;
2. copy theme: ```cp ./ohmyzsh-theme-passion/passion.zsh-theme ~/.oh-my-zsh/themes/passion.zsh-theme```;
3. modify rc: open ```~/.zshrc``` find ```ZSH_THEME``` edit to ```ZSH_THEME="passion"```;
4. execute rc: ```source ~/.zshrc```;

* see also: [Overriding and adding themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes);

#### Trouble Shooting

##### macOS, command not found: gdate

* passion.zsh-theme depends on cmd ```gdate``` to get current time in milliseconds. get ```gdate``` on macOS by running ```brew install coreutils``` then ```source ~/.zshrc```;
* see also: [#12](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/12);

##### Linux, command not found: bc

* passion.zsh-theme depends on cmd ```bc``` to calculate the command running time cost. [get bc on Linux](https://www.tecmint.com/bc-command-examples/#:~:text=If%20you%20don%E2%80%99t%20have%20bc%20on%20your%20system%2C,command%20prompt%20and%20simply%20start%20calculating%20your%20expressions.) then ```source ~/.zshrc```;
* see also: [#13](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/13);

##### Centos 7, shell exit

* may caused by [set timer to zsh prompt](https://github.com/ChesterYue/ohmyzsh-theme-passion/blob/8f71c43c2df91810249ab00ff40fc4ca63207467/passion.zsh-theme#L197-L208);
* see also: [#4](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/4);

<details> <!-- markdownlint-disable-line -->
<summary><h3>Extra Preferences</h3></summary> <!-- markdownlint-disable-line -->

#### Zsh Plugins

1. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions);
2. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting);

#### iTerm2 Preferences

##### Color

<!-- cspell:disable-next-line -->
* iTerm2: settings -> Profiles -> Colors -> Color Presets -> import ```./passion.itermcolors``` ![color.png](./image/color.png)
* alternate terminal: try [Alternate terminal installation and configuration](https://iterm2colorschemes.com/);

##### Status Bar

* iTerm2: settings -> Appearance && settings -> Profiles -> Session -> Configure Status Bar ![status_0.png](./image/status_0.png) ![status_1.png](./image/status_1.png)

##### Font

* install [JetBrains Mono](https://www.jetbrains.com/lp/mono/);
* iTerm2: settings -> Appearance && settings -> Profiles -> Text -> Font ![font.png](./image/font.png)

</details> <!-- markdownlint-disable-line -->
