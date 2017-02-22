#!/bin/bash

MIN_XCODE_VERSION="8.2"
MIN_RUBY_VERSION="2.0"

vercomp () {
	if [[ $1 == $2 ]]
	then
		return 0
	fi
	local IFS=.
	local i ver1=($1) ver2=($2)
	# fill empty fields in ver1 with zeros
	for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
	do
		ver1[i]=0
	done
	for ((i=0; i<${#ver1[@]}; i++))
	do
		if [[ -z ${ver2[i]} ]]
		then
			# fill empty fields in ver2 with zeros
			ver2[i]=0
		fi
		if ((10#${ver1[i]} > 10#${ver2[i]}))
		then
			return 1
		fi
		if ((10#${ver1[i]} < 10#${ver2[i]}))
		then
			return 2
		fi
	done
	return 0
}

check_xcode() {
	xversion=$( xcodebuild -version | head -n1 | cut -d ' ' -f2 )
	vercomp $MIN_XCODE_VERSION $xversion
	if [ $? -ne 2 ] ; then
		echo "The version of Xcode installed on your machine is too low. Please update to $MIN_XCODE_VERSION"
		exit 1
	fi
	
	return 0
}

check_ruby() {
	ruby_version=$( ruby -v | cut -d ' ' -f2 | sed 's/.p//' )
	vercomp $MIN_RUBY_VERSION $ruby_version
	if [ $? -ne 2 ] ; then
		echo "The version of Ruby installed on your machine is too low. Please update to $MIN_RUBY_VERSION"
		exit 1
	fi
	
	return 0
}

check_git() {
	if ! [ -x "$(command -v git)" ] ; then
		echo "You don't have git installed on your computer"
		exit 1
	fi
	
	return 0
}

check_cocoapods() {
	if ! [ -x "$(command -v pod)" ] ; then
		echo "You don't have CocoaPods installed on your computer"
		echo "Please run this command: gem install cocoapods"
		exit 1
	fi
		
	return 0	
}

if 	type xcode-select >&- && 
	xpath=$( xcode-select --print-path ) && 
	test -d "${xpath}" && 
	test -x "${xpath}" ; 
then
	check_xcode
	check_git
	check_ruby
	check_cocoapods
	
	echo "Everything's fine! You're ready to go! 🙌"
else
	echo "Xcode isn't installed on your computer 😢"
	exit 1
fi