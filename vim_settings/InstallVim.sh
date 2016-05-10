#!/usr/bin/sh
sudo apt-get install git build-essential cmake python-dev python3-dev ctags vim

cp ~/Settings/vim_settings/.vim ~/.vim
cp ~/Settings/vim_settings/.vimrc ~/.vimrc
rm -rf ~/Settings

echo "Your name:\c"
read name
echo "Your e-mail:\c"
read email
sed -i '' 's/David/'name'/g' ~/.vimrc
sed -i '' 's/youchen\.du@gmail\.com/'email'/g' ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
sudo vim +PluginInstall +qall


