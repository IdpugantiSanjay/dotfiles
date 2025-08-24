function services
    set -l urls (xh https://traefik.pi.sanjayidpuganti.com/api/http/routers --auth sanjay:18483af2ba30a956 |
        jq '.[].rule' -r |
        grep "Host.*sanjayidpuganti" |
        grep -o 'Host(`[^`]*`)' |
        grep "$argv[1]" |
        cut -d'`' -f2)

    if test (count $urls) -eq 1
        xdg-open "https://$urls[1]"
    else
        echo $urls | tr ' ' '\n' | fzf --query="$argv[1]" | xargs -I {} xdg-open https://{}
    end
end
