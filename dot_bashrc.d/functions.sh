#!/usr/bin/env bash

function github() {
  if [[ $1 == 'repos' ]]
  then
    local view="${3:-code}"
    firefox "https://github.com/IdpugantiSanjay/$2/$view"
  elif [[ $1 == 'gists' ]]
  then
    gists=("ansible-dev-setup" "ansible-amz-linux")
    case $2 in
      "${gists[1]}")
        firefox "https://gist.github.com/IdpugantiSanjay/174ae467ca930803c49b5497d6468e61"
        ;;
      "${gists[0]}")
        firefox "https://gist.github.com/IdpugantiSanjay/5f2d3008013b6f0aaf8167566539d9e5"
        ;;
      *)
        >&2 echo "Invalid gist please select any of: ${gists[@]}"
        ;;
      esac
  fi
}

function youtube() {
  options=("subs" "watch-later")
  case $1 in
    "${options[0]}")
      firefox "https://www.youtube.com/feed/subscriptions"
      ;;
    "${options[1]}")
      firefox "https://www.youtube.com/playlist?list=WL"
      ;;
    *)
      >&2 echo "Invalid option. Please select any of: ${options[@]}"
      ;;
    esac
}

function open() {
  options=("todos")
  case $1 in
    "${options[0]}")
      firefox "https://to-do.live.com/tasks/myday"
      ;;
    *)
      >&2 echo "Invalid option. Please select any of: ${options[@]}"
      ;;
  esac
}


function backup-dotfiles() {
  cp -ivr ~/.bashrc.d/* ~/dotfiles/bash/.bashrc.d/
  cp ~/.config/starship.toml ~/dotfiles/starship/
  cp ~/.ssh/config ~/dotfiles/ssh/
  cp ~/.tmux.conf ~/dotfiles/tmux/.tmux.conf
  cp ~/.bashrc ~/dotfiles/bash/
  cp ~/.config/broot/verbs.hjson ~/dotfiles/broot/
  cp -ivr ~/.config/kitty/* ~/dotfiles/kitty/
}

function mkcd() {
  if [[ ! -d "$@" ]]; then mkdir -p "$@"; fi
  cd "$@";
}


function google() {
 firefox "https://www.google.com/search?q=$1"
}


function trx() {
  if [[ ! -f $2 ]]
  then
    echo "$2 does not exist"
    return 1
  fi
  categories=("food" "mf")
  case $1 in
    "${categories[1]}")
        xsv sort -Rs 4 "$2" | 
        xsv select Date,Narration,'Debit Amount' | 
        xsv search -s Narration -i 'Clearing' | 
        xsv table |
        awk '{if (NF>1) {sum+=$NF}; print $0} END {printf "Total: ₹%.2f\n", sum}'
        ;;
    "${categories[0]}")
        xsv sort -Rs 4 "$2" | 
        xsv select Date,Narration,'Debit Amount' | 
        xsv search -s Narration -i 'Zomato|Swiggy' | 
        xsv table |
        awk '{if (NF>1) {sum+=$NF}; print $0} END {printf "Total: ₹%.2f\n", sum}'
        ;;
    *)
      >&2 echo "Invalid category. Please select any of: ${categories[@]}"
      ;;
    esac
}
