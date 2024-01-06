function update
    command -v dnf > /dev/null && sudo dnf update -y
    command -v apt > /dev/null && sudo apt update -y && sudo apt upgrade -y
    command -v brew > /dev/null && brew update && brew upgrade
    command -v cargo > /dev/null && cargo install $(cargo install --list | awk '/:$/ { print $1; }')
    command -v npm > /dev/null && sudo npm update -g
end
