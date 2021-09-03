#!/bin/bash

cd ~/Downloads || exit 1

pkgNeeded="7z"

# Verify if the Windows iso file exist or not
[ ! -e "Win*.iso" ] && echo "Windows file not found" && exit 2

# Check which package manager to use to install the $pkgNeeded
VerifyPkgAndInstall() {
if [ -x "$(command -v apk)" ]; then pkgmgr="apk"
    elif [ -x "$(command -v apt-get)" ]; then pkgmgr="apt-get"
    elif [ -x "$(command -v zypper)" ]; then pkgmgr="zypper"
    elif [ -x "$(command -v xbps)" ]; then pkgmgr="xbps"
    elif [ -x "$(command -v dnf)" ]; then pkgmgr="dnf"
    else echo "Can't find a package manager!!" && exit 2
fi
   sudo $pkgmgr install $pkgNeeded || exit 2
}

# Extract and copy the fonts to the right path
install_fonts() {
  7z e Win*.iso sources/install.wim
  7z e install.wim 1/Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/*/*/license.rtf} -o fonts/ || echo "Failed to extract the fonts..." && exit 2
  sudo cp -r fonts/*.ttf /usr/share/fonts/TTF/
}

if command -v 7z &>/dev/null ; then
  install_fonts
else
  VerifyPkgAndInstall
  install_fonts
fi


#echo 61 64 61 6C 38 37 37 | xxd -r -p | xargs -I{} printf "{}\n"
