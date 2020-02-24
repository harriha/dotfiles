alias ll='ls -la'
alias ls='ls -hF --color=tty'
alias subl='/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe'
alias chrome='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias code='/c/Program\ Files\ \(x86\)/Microsoft\ VS\ Code/code.exe'

function perf {
  curl -o /dev/null -s -k -w "%{time_connect} + %{time_starttransfer} = %{time_total}\n" "$1"
}

# Auto-complete SSH hosts
#   From https://gist.github.com/aliang/1024466
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export FORCE_COLOR=true

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

