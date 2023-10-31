# simplerich-zsh-theme

## Overview

This is an oh-my-zsh theme with informative git status, venv/Anaconda environment info and command execution time.

![demo.png](./readme/demo.png)

### Features

You can see the followings at once:

- Real time
- Login user
- Working directory
- Venv/Anaconda's environment name
- Rich git status

After command execution, you can see also:

- Command execution time
- Success/Error hint

## Git Status Symbols

The git status is updated immediately after a command is finished or every 10 seconds after the terminal is started.

| Symbol        | Meaning                                                                                                                     |
| ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `[main]`      | The repository is clean.                                                                                                    |
| `[main +n]`   | There are n staged files.                                                                                                   |
| `[main ●n]`   | There are n changed but unstaged files.                                                                                     |
| `[main …n]`   | There are n untracked files.                                                                                                |
| `[main xn]`   | There are n conflicting files.                                                                                              |
| `[main n\|m]` | The local branch is m commits ahead and n commits behind the remote branch.                                                 |
| `[main *]`    | This will be displayed instead of the informative symbols<br />when python cannot be executed and the repository not clean. |

## Install

1. Clone the repository & copy the zsh-theme file.

```shell
# cd path/to/where_u_want_to_clone_the_repo
git clone --recursive https://github.com/philip82148/simplerich-zsh-theme
cp ./simplerich-zsh-theme/simplerich.zsh-theme ~/.oh-my-zsh/themes/
```

2. Edit ~/.zshrc.

```shell
# file:~/.zshrc
# Find the line that reads ZSH_THEME="..." and replace it with the followings.
ZSH_THEME="simplerich"
source path/to/where_u_want_to_clone_the_repo/simplerich-zsh-theme/zsh-git-prompt/zshrc.sh
```

**Attention**

- These must be BEFORE the line `source $ZSH/oh-my-zsh.sh` in `~/.zshrc`.
- Change the path of `source .../zsh-git-prompt/zshrc.sh` according to your environment.
- If you comment out `source .../zsh-git-prompt/zshrc.sh` or you cannot use `python` command, you can use a simpler git status like the following:  
  ![simpler-git-status.png](./readme/simpler-git-status.png)

3. If you use venv, remove the original display of the environment name.

```shell
echo "export VIRTUAL_ENV_DISABLE_PROMPT=1" >> ~/.zshrc
```

Or if you use Anaconda, run this:

```shell
conda config --set changeps1 False
```

4. Load ~/.zshrc.

```shell
source ~/.zshrc
```

See also [Overriding and adding themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes) and [zsh-git-prompt](https://github.com/olivierverdier/zsh-git-prompt).

## Trouble Shooting

### On macOS, Command Not Found: gdate

- simplerich.zsh-theme depends on cmd `gdate` to get current time in milliseconds. get `gdate` on macOS by running `brew install coreutils` then `source ~/.zshrc`.
- See also [#12](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/12).

### On Linux, Command Not Found: bc

- simplerich.zsh-theme depends on cmd `bc` to calculate the command running time cost. [get bc on Linux](https://www.tecmint.com/bc-command-examples/#:~:text=If%20you%20don%E2%80%99t%20have%20bc%20on%20your%20system%2C,command%20prompt%20and%20simply%20start%20calculating%20your%20expressions.) then `source ~/.zshrc`.
- See also [#13](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/13).

### On Centos 7, Shell Exit

- It may be caused by [set timer to zsh prompt](https://github.com/ChesterYue/ohmyzsh-theme-passion/blob/8f71c43c2df91810249ab00ff40fc4ca63207467/passion.zsh-theme#L197-L208).
- See also [#4](https://github.com/ChesterYue/ohmyzsh-theme-passion/issues/4).

## Extra Preferences

### Zsh Plugins

1. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
2. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
3. [zsh-completions](https://github.com/zsh-users/zsh-completions)
4. [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

### iTerm2 Preferences

#### Color

<!-- cspell:disable-next-line -->

- iTerm2: Settings -> Profiles -> Colors -> Color Presets -> Import `./simplerich.itermcolors`
  ![color.png](./readme/color.png)
- Alternate terminal: Try [Alternate terminal installation and configuration](https://iterm2colorschemes.com/).

#### Status Bar

- iTerm2: Settings -> Appearance && settings -> Profiles -> Session -> Configure Status Bar
  ![status_0.png](./readme/status_0.png) ![status_1.png](./readme/status_1.png)

#### Font

- Install [JetBrains Mono](https://www.jetbrains.com/lp/mono/).
- iTerm2: Settings -> Appearance && settings -> Profiles -> Text -> Font
  ![font.png](./readme/font.png)
