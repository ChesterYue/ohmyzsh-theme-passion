# gdate for macOS
# REF: https://apple.stackexchange.com/questions/135742/time-in-milliseconds-since-epoch-in-the-terminal
if [[ "$OSTYPE" == "darwin"* ]]; then
    {
        gdate
    } || {
        echo "\n$fg_bold[yellow]simplerich.zsh-theme depends on cmd [gdate] to get current time in milliseconds$reset_color"
        echo "$fg_bold[yellow][gdate] is not installed by default in macOS$reset_color"
        echo "$fg_bold[yellow]to get [gdate] by running:$reset_color"
        echo "$fg_bold[green]brew install coreutils;$reset_color"
        echo "$fg_bold[yellow]\nREF: https://github.com/ChesterYue/ohmyzsh-theme-passion#macos\n$reset_color"
    }
fi

_simplerich_current_time_millis() {
    local time_millis
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        time_millis="$(date +%s.%3N)"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        time_millis="$(gdate +%s.%3N)"
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
    else
        # Unknown.
    fi

    echo $time_millis
}

_simplerich_update_git_info() {
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        _SIMPLERICH_GIT_INFO=$(git_super_status)
    else
        _SIMPLERICH_GIT_INFO=$(_omz_git_prompt_info)
    fi
}

# command execute before
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
preexec() { # cspell:disable-line
    _SIMPLERICH_COMMAND_TIME_BEGIN="$(_simplerich_current_time_millis)"
}

# command execute after
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
precmd() { # cspell:disable-line
    local last_cmd_return_code=$?

    update_command_status() {
        local color=""
        local command_result=$1
        if $command_result; then
            color=""
        else
            color="%{$fg[red]%}"
        fi

        _SIMPLERICH_COMMAND_STATUS="${color}%(!.#.$)%{$reset_color%}"
    }

    output_command_execute_after() {
        if [ "$_SIMPLERICH_COMMAND_TIME_BEGIN" = "-20200325" ] || [ "$_SIMPLERICH_COMMAND_TIME_BEGIN" = "" ]; then
            return 1
        fi

        # cmd
        local cmd="$(fc -ln -1)"
        local color_cmd=""
        local command_result=$1
        if $command_result; then
            color_cmd="$fg[green]"
        else
            color_cmd="$fg[red]"
        fi
        local color_reset="$reset_color"
        cmd="${color_cmd}${cmd}${color_reset}"

        # time
        local time="[$(date +%H:%M:%S)]"

        # cost
        local time_end="$(_simplerich_current_time_millis)"
        local cost=$(bc -l <<<"${time_end}-${_SIMPLERICH_COMMAND_TIME_BEGIN}")
        _SIMPLERICH_COMMAND_TIME_BEGIN="-20200325"
        local length_cost=${#cost}
        if [ "$length_cost" = "4" ]; then
            cost="0${cost}"
        fi
        cost="[cost ${cost}s]"

        echo "${time} $fg[cyan]${cost}${color_reset} ${cmd}\n\n"
    }

    # last_cmd
    local last_cmd_result=true
    if [ "$last_cmd_return_code" = "0" ]; then
        last_cmd_result=true
    else
        last_cmd_result=false
    fi

    _simplerich_update_git_info

    update_command_status $last_cmd_result

    output_command_execute_after $last_cmd_result
}

# set option
setopt PROMPT_SUBST # cspell:disable-line

# timer
#REF: https://stackoverflow.com/questions/26526175/zsh-menu-completion-causes-problems-after-zle-reset-prompt
TMOUT=1
TRAPALRM() { # cspell:disable-line
    # $(git_prompt_info) cost too much time which will raise stutters when inputting. so we need to disable it in this occurrence.
    # if [ "$WIDGET" != "expand-or-complete" ] && [ "$WIDGET" != "self-insert" ] && [ "$WIDGET" != "backward-delete-char" ]; then
    # black list will not enum it completely. even some pipe broken will appear.
    # so we just put a white list here.
    if [ "$WIDGET" = "" ] || [ "$WIDGET" = "accept-line" ]; then
        zle reset-prompt
    fi

    if [ "$_SIMPLERICH_PROMPT_CALLED_COUNT" -eq 0 ]; then
        _simplerich_update_git_info
    fi

    local count="$((_SIMPLERICH_PROMPT_CALLED_COUNT + 1))"
    if [ "$count" -ge 10 ]; then
        count=0
    fi
    export _SIMPLERICH_PROMPT_CALLED_COUNT=$count
}

# git
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="  %{$fg[yellow]%}*"

# zsh-git-prompt
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{x%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%}|"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

git_super_status() {
    precmd_update_git_vars >/dev/null 2>&1

    if [ -z "$__CURRENT_GIT_STATUS" ]; then
        return
    fi

    if [ "$GIT_BRANCH" = ":" ]; then
        echo ""
        return
    fi

    local git_status="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
    if [ "$GIT_BEHIND" -ne "0" ] || [ "$GIT_AHEAD" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
    fi

    if [ "$GIT_CHANGED" -ne "0" ] || [ "$GIT_CONFLICTS" -ne "0" ] || [ "$GIT_STAGED" -ne "0" ] || [ "$GIT_UNTRACKED" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_SEPARATOR"
    fi

    if [ "$GIT_STAGED" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
    fi
    if [ "$GIT_CONFLICTS" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_UNTRACKED$GIT_UNTRACKED%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
        git_status="$git_status$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
    git_status="$git_status%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"

    echo $git_status
}

_simplerich_prompt() {
    real_time() {
        # echo "[%*]";
        echo "[$(date +%H:%M:%S)]"
    }

    user_info() {
        echo "%n"
    }

    python_info() {
        if [ -v CONDA_DEFAULT_ENV ]; then
            echo "%{$fg[magenta]%}(${CONDA_DEFAULT_ENV})%{$reset_color%}"
        elif [ -v VIRTUAL_ENV ]; then
            local parent=$(dirname ${VIRTUAL_ENV})
            if [[ "${PWD/#$parent/}" != "$PWD" ]]; then
                # PWD is under the parent
                echo "%{$fg[magenta]%}($(basename ${VIRTUAL_ENV}))%{$reset_color%}"
            else
                # PWD is not under the parent
                echo "%{$fg[magenta]%}(${VIRTUAL_ENV/#$HOME/~})%{$reset_color%}"
            fi
        fi
    }

    directory_info() {
        #    echo "%c";
        echo "%{$fg[cyan]%}${PWD/#$HOME/~}%{$reset_color%}"
    }

    git_info() {
        echo "${_SIMPLERICH_GIT_INFO}"
    }

    command_status() {
        echo "${_SIMPLERICH_COMMAND_STATUS}"
    }

    if [ -v CONDA_DEFAULT_ENV ] || [ -v VIRTUAL_ENV ]; then
        echo "$(real_time) $(user_info) $(python_info) $(directory_info) $(git_info)
$(command_status) "
    else
        echo "$(real_time) $(user_info) $(directory_info) $(git_info)
$(command_status) "
    fi
}

PROMPT='$(_simplerich_prompt)'
