#!/bin/bash

# This script encrypt passwords using the RSA algorithm
function verify_file()
{
	if test -f $1
	then
		echo "file: $1 is loaded"
		FILE=$1
	else
		echo "file: $1 could not be loaded"
		exit 1

	fi
}

function verify_keys()
{	

	if [[ $2 = "-a" ]]
		then
		if test -f ~/.ssh/id_rsa && test -f ~/.ssh/id_rsa.pub
			then			
			PRIVATE_KEY=$(realpath ~/.ssh/id_rsa)
			PUBLIC_KEY=$(realpath ~/.ssh/id_rsa.pub)
			echo "default keys loaded"
		fi
	elif [[ "$#" -ge 4 ]]
		then 
			if test -f $2 && test -f $3
	 		then
				PRIVATE_KEY=$2
				PUBLIC_KEY=$3
				echo "keys loaded"
			elif ! test -e $2
				then
					echo "key: $2 could not be loaded"
					exit 2
			else
				echo "key: $3 could not be loaded"
				exit 3	
			fi
	else
		echo "please make sure that you provide : a file to encrypt, private and public key"
		exit 4
	 	
	 fi
	
}
function key_to_PKCS()
{
	PUBLIC_KEY_PKCS=$(basename $PUBLIC_KEY).pkcs8 
	if ssh-keygen -e -f $PUBLIC_KEY -m PKCS8 > ./$PUBLIC_KEY_PKCS
	then
		echo "$PUBLIC_KEY_PKCS is created"
	else
		echo "Not able to create PKCS key"
		exit 5
	fi
}

function function_encrypt()
{
	if test -n $PRIVATE_KEY && test -n $PUBLIC_KEY_PKCS && test -n $FILE
	then
		OUTPUT_FILE=$FILE.enc		
		if openssl rsautl -encrypt -pubin -inkey $PUBLIC_KEY_PKCS -in $FILE -out $OUTPUT_FILE
		then
			echo "Encryption ended successfully"
		else
			echo "An error occurred during the encryption"
			exit 6
		fi
	fi
}

function function_decrypt()
{
	if test -n $PRIVATE_KEY && test -n $PUBLIC_KEY_PKCS && test -n $FILE && test -n $OUTPUT_FILE
	then
		if openssl rsautl -decrypt -inkey $PRIVATE_KEY -in $FILE -out $OUTPUT_FILE
		then
			echo "decryption ended successfully"
		else
			echo "an error occured while decrypting your file"
			echo "openssl rsautl -decrypt -inkey $PRIVATE_KEY -in $FILE -out $OUTPUT_FILE"
		fi
	else
		echo "some parameters are not set"
	fi
}

PRIVATE_KEY=""
PUBLIC_KEY=""
PUBLIC_KEY_PKCS=""
FILE=""
OUTPUT_FILE=$4
verify_file $1
verify_keys $1 $2 $3
key_to_PKCS
function_decrypt



