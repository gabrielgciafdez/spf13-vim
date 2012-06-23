#!/usr/bin/env sh

endpath="$HOME/.spf13-vim-3"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing spf13-vim modified by gabrielgciafdez\n"

# Backup existing .vim stuff
echo "backing up current vim config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv $i $i.$today; done


echo "cloning spf13-vim\n"
git clone --recursive -b 3.0 http://github.com/gabrielgciafdez/spf13-vim.git $endpath
mkdir -p $endpath/.vim/bundle
ln -s $endpath/.vimrc $HOME/.vimrc
ln -s $endpath/.vim $HOME/.vim

echo "Installing Symfony2 Codesniffer Standard"
#pear_info=$(pear config-show | grep php_dir)
#echo $pear_info
#pear_dir=$pear_info | cut -d ' ' -f 4 | sed 's/ *$//g'
#echo $pear_dir
#codesniffer_stds_path="$pear_dir/PHP/CodeSniffer/Standards/"
codesniffer_stds_path="/usr/share/php/PHP/CodeSniffer/Standards"
git clone https://github.com/opensky/Symfony2-coding-standard.git $codesniffer_stds_path/Symfony2
# set Symfony2 std as default
phpcs --config-set default_standard Symfony2

echo "Installing Vundle"
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "installing plugins using Vundle"
vim +BundleInstall! +BundleClean +q
