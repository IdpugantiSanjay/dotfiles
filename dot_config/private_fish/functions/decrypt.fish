function decrypt -d "decrypt a file encrypted with age" -a encrypted
    set -l ends_with_age (echo "$encrypted" | grep '\.age$')
    if test -z $ends_with_age
        echo 'Can only decrypt files ending with .age' and return 0
    end
    cat $encrypted | age -d -i ~/.config/age/keys.txt > (echo "$encrypted" | sd '.age$' '')
end