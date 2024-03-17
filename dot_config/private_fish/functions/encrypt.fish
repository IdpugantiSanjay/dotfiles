function encrypt -d "encrypt a file with age and produce an encrypted file" -a file
    cat $file | age -r $age_public_key -o "$file.age"
end
