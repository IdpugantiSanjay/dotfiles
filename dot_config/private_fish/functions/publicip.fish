function publicip
    set -l ip  (curl -s https://ipinfo.io/ip)
    echo (string trim -- $ip)
end