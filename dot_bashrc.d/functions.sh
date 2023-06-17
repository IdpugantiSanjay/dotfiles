#!/usr/bin/env bash

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


gitir() {
  local URLS_TEXT_FILE=$1
  local COURSE_NAME=$2
  local CATEGORY=$3
  local DOWNLOAD_LOCATION

  if [ -z "$URLS_TEXT_FILE" ]; then
    echo "No URLS_TEXT_FILE provided. exiting"
    return 0
  fi

  if [ -z "$COURSE_NAME" ]; then
    echo "No COURSE_NAME provided. exiting"
    return 0
  fi

  if [ -z "$CATEGORY" ]; then
    echo "No CATEGORY provided. exiting"
    return 0
  fi

  DOWNLOAD_LOCATION=$(__category_download_location "$CATEGORY")

  # make sure the download path exists
  ssh dexter "mkdir -p $DOWNLOAD_LOCATION"

  # unmount if already mounted
  umount "$HOME"/network-drives/

  # mount the download path to client machine
  sshfs dexter:"$DOWNLOAD_LOCATION" "$HOME"/network-drives/

  mkdir -p "$DOWNLOAD_LOCATION"
  wget --directory-prefix "$HOME"/network-drives/"$COURSE_NAME" --input-file "$URLS_TEXT_FILE"
  
  __rename_gitir_files "$HOME"/network-drives/"$COURSE_NAME"
}


__category_download_location() {
  CATEGORY=$1
  local FOLDER
  case $CATEGORY in
    frontend)
      FOLDER='frontend'
      ;;
    non-technical)
      FOLDER='non-technical'
      ;;
    dotnet)
      FOLDER='dotnet'
      ;;
    linux)
      FOLDER='linux'
      ;;
    azure)
      FOLDER='azure'
      ;;
    security)
      FOLDER='security'
      ;;
    *)
      printf "No category found. Exiting"
      exit
  esac
  echo "$HOME/Downloads/$FOLDER-courses"
}

__rename_gitir_files() {
  local LOCATION
  LOCATION=$1

  if [ -z "$LOCATION" ]; then
    echo "No location provided. exiting"
    return 0
  fi

  fd git "$LOCATION/" | while read -r FILE; do
    NEW_FILE="$(echo "${FILE}" | sd '\-git\.ir' '')";
    mv -i "$FILE" "$NEW_FILE"
  done
}