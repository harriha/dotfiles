# ~/.bash_aliases

# Make interactive stuff to work with Git bash specifically
# See https://github.com/facebook/jest/issues/3079#issuecomment-351847128
# and https://superuser.com/a/1322277
# See https://github.com/rprichard/winpty/issues/103 for addition switches
alias inpm='winpty npm.cmd'

alias ll='ls -la'
alias ls='ls -hF --color=tty'

#alias code='/c/Users/hhal/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe'
#alias code='/c/Program\ Files/Microsoft\ VS\ Code/code.exe'
#alias chrome='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'

alias fyi='echo \
    Count lines recursively: find src/ -name \"*.js\" \| xargs wc -l \
'

alias showhosts='cat /c/Windows/System32/Drivers/etc/hosts'

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

alias dockercleanalli='docker rmi $(docker images -q)'

alias _awswhoami='aws sts get-caller-identity'
