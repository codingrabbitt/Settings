#!/bin/sh
echo "This script will overwrite files on this computer."
echo "Please make sure you have .vimrc file backup."
echo "To continue input \"Y\", cancel input \"N\":\c"
read choice
if [ "$choice"x = "Y"x ]
then
    sudo apt-get remove vim vim-common
    sudo apt-get install build-essential cmake python-dev ctags vim

    sudo rm -rf ~/.vim
    sudo rm -rf ~/.vimrc
    sudo cp -r ~/Settings/vim_settings/.vim ~/.vim
    sudo cp -r ~/Settings/vim_settings/.vimrc ~/.vimrc
    
    echo "Your name:\c"
    read name
    echo "Your e-mail:\c"
    read email
    sed -i 's/David/'$name'/g' ~/.vimrc
    sed -i 's/youchen\.du@gmail\.com/'$email'/g' ~/.vimrc
    sed -i "s/\(Tlist_Ctags_Cmd\ =\).*/\1 '\/usr\/bin\/ctags'/g" .vimrc
    
    sudo git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
    sudo vim +PluginInstall +qall
else
    echo "Canceled."
fi
