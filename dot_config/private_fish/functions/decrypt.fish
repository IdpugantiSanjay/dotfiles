function decrypt -d "decrypt a file encrypted with age" -a encrypted
    cat $encrypted | age -d -i "/home/sanjay/Documents/age-yubikey-identity-97ef0b73.txt" > (echo "$encrypted" | sd ".age" "")
end