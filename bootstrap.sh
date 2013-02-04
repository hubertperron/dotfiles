#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"
git pull
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt

echo
read -p "Load OS X custom settings? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	source ~/.osx
fi

echo
read -p "Install Liip php? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -s http://php-osx.liip.ch/install.sh | bash -s 5.4
fi

source ~/.bash_profile