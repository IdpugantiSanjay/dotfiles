function update
    sudo dnf update -y
    brew update
    brew upgrade
    cargo install $(cargo install --list | awk '/:$/ { print $1; }')
end
