function decrypt -d "decrypt a file encrypted with age" -a encrypted output
    cat $encrypted | age -d -i "/home/sanjay/age-yubikey-identity-97ef0b73.txt" > $output
end