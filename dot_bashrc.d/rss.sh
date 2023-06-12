
rss=~/Work/RiderProjects/Rss/Rss.Cli/bin/Debug/net7.0/Rss.Cli

rss() {
    local feed 
    local item
    local link
    local action
    local feedType
    
    feedType=$(gum choose "Feed" "Read Later" "Latest")
    if [[ $feedType == "Read Later" ]]
    then
        __rss_read_later
    elif [[  $feedType == "Feed" ]] 
    then
        __rss_feed
    elif [[ $feedType == "Latest" ]]
    then
        __rss_latest 
    fi
}  


rss-pull() {
    gum spin --spinner minidot --title "Fetching Latest Items from feeds..." --show-output -- $rss pull
}

__rss_read_later() {
    item=$(gum spin --spinner minidot --title "Fetching Read Later Items..." --show-output -- $rss read-later ls | gum choose --header="Pick a feed item from read later" | sd '\[\d.*\].*' '' | sd '[ \t]+$' '' | sd '^\s+' '')
    if [[ -n $item ]]
    then
        action=$(gum choose "Open" "Remove" --header="Choose an action")
        if [[ $action == "Open" ]]
        then
            link=$(gum spin --spinner minidot --title "Fetching Url..." --show-output -- $rss item-link "$item")
            firefox "$link" > /dev/null 2> /dev/null  & disown
        elif [[ $action == "Remove" ]]; then
            gum spin --spinner minidot --title "Deleting $item..." --show-output -- $rss read-later rm "$item" && __rss_read_later
        fi
    fi
} 

__rss_feed() {
    local feed 
    local item
    local link
    local action

    if [[ -n $1 ]]
    then
        feed=$1
        action="List"
    else
        feed=$(gum spin --spinner minidot --title "Fetching Feeds..." --show-output -- $rss ls | gum choose --header="Pick a feed")
        if [[ -n $feed ]] 
        then
            action=$(gum choose "List" "Favorite" "Remove" --header="Choose an action")
        fi
    fi
    
    if [[ $action == "List" ]]
    then
        item=$(gum spin --spinner minidot --title "Fetching Feed Items..." --show-output -- $rss fetch "$feed" | gum choose --header="Pick a feed item" | sd '\[\d.*\].*' '' | sd '[ \t]+$' '' | sd '^\s+' '')
        if [[ -n $item ]]
        then
            action=$(gum choose "Open" "Read Later" "Remove" "Add to Todoist" --header="Pick an action")
            if [[ $action == "Open" ]]
            then
                link=$(gum spin --spinner minidot --title "Fetching Url..." --show-output -- $rss item-link "$item")
                firefox "$link" > /dev/null 2> /dev/null  & disown
            elif [[ $action == "Remove" ]]; then
                gum spin --spinner minidot --title "Deleting $item..." --show-output -- $rss items rm "$item" && __rss_feed "$feed"
            elif [[ $action == "Read Later" ]] then
                gum spin --spinner minidot --title "Adding $item to Read Later..." --show-output -- $rss read-later add "$item" && __rss_feed "$feed"
            elif [[ $action == "Add to Todoist" ]] then
#                echo "$item"
                
                link=$(gum spin --spinner minidot --title "Fetching $item url..." --show-output --  $rss item-link "$item")
#                echo "$item" 
#                echo "$link"
                
                gum spin --spinner minidot --title "Adding $item to Todo-list..." --show-output -- $rss todo add "$item" "$link"
#                link=$($rss item-link "$item")
 #               $rss todo add "$item" "$link"
#                __rss_add_to_todoist "$item" "$link"
                                # __rss_add_to_todoist "$item" "$link"
                # __rss_feed "$feed"
                # gum spin --spinner minidot --title "Adding $item to Todoist..." --show-output -- $(__rss_add_to_todoist "$item" "$link")
                __rss_feed "$feed"
                
            fi
        fi
    elif [[ $action == "Remove" ]] && [[ -n $feed ]]; then
        gum spin --spinner minidot --title "Removing $feed..." --show-output -- $rss rm "$feed" && __rss_feed "$feed"
    fi
}

__rss_latest() {
    local feed 
    local item
    local link

    # item=$($rss latest | fzf --bind 'ctrl-d:execute(echo {1..} | rss-delete)' | sd '\[\d.*\].*' '' | sd '[ \t]+$' '' | sd '^\s+' '')
    item=$(gum spin --spinner minidot --title "Fetching Latest Feed Items..." --show-output -- $rss latest | gum choose | sd '\[\d.*\].*' '' | sd '[ \t]+$' '' | sd '^\s+' '')
    if [[ -n $item ]] 
    then
        link=$(gum spin --spinner minidot --title "Fetching Url..." --show-output -- $rss item-link "$item")
    fi
    if [[ -n $link ]]
    then
        firefox "$link" > /dev/null 2> /dev/null  & disown
    fi
}

__rss_add_to_todoist() {
    local script
    script=/home/sanjay/PycharmProjects/todoist/main.py
#    content=echo "$1" | sd '\[\d.*\].*' '' | sd '[ \t]+$' '' | sd '^\s+' ''
    # echo "$1"
    # echo "$2"
    $script -c "$1" -d "$2"
    return 0
}