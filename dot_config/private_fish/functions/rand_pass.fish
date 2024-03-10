function rand_pass --argument length -d "password length"
	set -q length[1]
	or set length 16
	openssl rand --base64 $length
end
