if status is-interactive
 eval "$(/opt/homebrew/bin/brew shellenv)"
 eval "$(rbenv init - --no-rehash zsh)"  
 # Commands to run in interactive sessions can go here
end
fzf --fish | source
