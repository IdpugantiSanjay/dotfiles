function encrypt -d "encrypt a file with age and produce an encrypted file" -a file
    cat $file | age -r "age1yubikey1q23v9tnfz7f0y0r8rnpv570z5z8kzwny9u2fudqysugkqf0092w3s6ueu9q" -o "$file.age"
end
