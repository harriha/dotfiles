function perf {
  curl -o /dev/null -s -k -w "%{time_connect} + %{time_starttransfer} = %{time_total}\n" "$1"
}

# Auto-complete SSH hosts
#   From https://gist.github.com/aliang/1024466
#_complete_ssh_hosts ()
#{
#        COMPREPLY=()
#        cur="${COMP_WORDS[COMP_CWORD]}"
#        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
#                        cut -f 1 -d ' ' | \
#                        sed -e s/,.*//g | \
#                        grep -v ^# | \
#                        uniq | \
#                        grep -v "\[" ;
#                cat ~/.ssh/config | \
#                        grep "^Host " | \
#                        awk '{print $2}'
#                `
#        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
#        return 0
#}
#complete -F _complete_ssh_hosts ssh

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export FORCE_COLOR=true

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


# Add git info to terminal
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[33m\]$(parse_git_branch)\[\033[00m\]\$ '

alias _awswhoami='aws sts get-caller-identity'

alias yarni='YARN_CHECKSUM_BEHAVIOR=ignore yarn'

# Relates Docker setup as per
# https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly
export DOCKER_HOST=tcp://localhost:2375

# https://devblogs.microsoft.com/commandline/sharing-ssh-keys-between-windows-and-wsl-2/
eval `keychain --agents ssh --eval id_rsa`
# ...or the next option

# From https://github.com/abergs/ubuntuonwindows#2-start-an-bash-ssh-agent-on-launch
# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initializing new SSH agent..."
     touch $SSH_ENV
     chmod 600 "${SSH_ENV}"
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     kill -0 $SSH_AGENT_PID 2>/dev/null || {
         start_agent
     }
else
     start_agent
fi


# Set PATH so it includes Android-Sdk if it exists
if [ -d "$HOME/Android-Sdk" ]; then
    ANDROID_HOME="$HOME/Android-Sdk"
    PATH="$ANDROID_HOME/emulator:$PATH"
    PATH="$ANDROID_HOME/tools:$PATH"
    PATH="$ANDROID_HOME/tools/bin:$PATH"
    PATH="$ANDROID_HOME/platform-tools:$PATH"
fi

export ANDROID_HOME

# Export host home dir as WINHOME
# See https://superuser.com/questions/1271205/how-to-get-the-host-user-home-directory-in-wsl-bash/1271221
export WINHOME=$(wslpath $(cmd.exe /C "echo %USERPROFILE%" 2>/dev/null) | tr -d '\r')

if [ -f "$WINHOME/.bash_aliases_wsl" ]; then
    . "$WINHOME/.bash_aliases_wsl"
fi

# https://consoledonottrack.com/
export DO_NOT_TRACK=1
