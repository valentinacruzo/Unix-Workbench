#!/usr/bin/env bash
# Author   : Valentina Cruz Olace
# Date     : April 26 2022
# ID       : 554801
subdirectories() {
	printf "Guessing Game in Bash"
	while read -r -p "Include subdirectories? [y/n] " subdirs; do
		if [[ "$subdirs" =~ ^([yY][eE][sS]|[yY])$ ]]; then
			numfiles=$(find . ! -type d | grep -v '.git' -c)
			subdirsv="current directory and subdirectories:"
			printf "\033[32m%s \n\n\033[0m" "Ok, subdirectories add!"
			break;
		elif [[ "$subdirs" =~ ^([nN][oO]|[nN])$ ]]; then
			numfiles=$(find . -maxdepth 1 ! -type d | wc -l)
			subdirsv="current directory only:"
			printf "\033[32m%s \n\n\033[0m" "Ok, subdirectories cut out!"
			break;
		else
			printf "\033[31m%s \n\033[0m" "Wrong answer..."
		fi
	done
}
 
guessing() {
	printf "Guess the number of files of the %s\n\n" "$subdirsv"
	attempts=1
	while read -r -p "Attempt $attempts → Type a number: " answer; do
		if [[ "$answer" =~ ^[0-9]+$ ]]; then
			if [[ "$answer" -lt "$numfiles" ]] 2>/dev/null; then
				printf "\033[33m%s \n\n\033[0m" "Too low!"
				attempts=$((attempts + 1))
			elif [[ "$answer" -gt "$numfiles" ]] 2>/dev/null; then
				printf "\033[33m%s \n\n\033[0m" "Too high!"
				attempts=$((attempts + 1))
			elif [ "$answer" -eq "$numfiles" ] 2>/dev/null; then
				printf "\033[32m%s \n\n\033[0m" "Congratulations! You win!"
				exit 0
			fi
		else
			printf "\033[31m%s \n\n\033[0m" "Wrong answer..."
			attempts=$((attempts + 1))
		fi
	done
}
 
subdirectories
guessing
