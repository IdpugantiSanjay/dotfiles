function services
    xh https://traefik.pi.sanjayidpuganti.com/api/http/routers --auth sanjay:18483af2ba30a956 |
        jq '.[].rule' -r |
        grep "Host.*sanjayidpuganti" |
        grep -o 'Host(`[^`]*`)' | # this will handle multiple hosts
        cut -d'`' -f2 |
        fzf --query="$argv[1]" |
        xargs -I {} xdg-open https://{}
end
