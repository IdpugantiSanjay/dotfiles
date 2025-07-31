function services
    xh https://traefik.pi.sanjayidpuganti.com/api/http/routers --auth sanjay:18483af2ba30a956 |
        jq '.[].rule' -r |
        grep "Host.*sanjayidpuganti" |
        cut -d'`' -f2 |
        fzf |
        xargs -I {} xdg-open https://{}
end
