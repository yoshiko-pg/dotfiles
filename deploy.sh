#! /bin/sh
cd `dirname $0`
DOT_DIRECTORY=`pwd`

for f in .??*
do
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

mkdir ${HOME}/.config
mkdir ${HOME}/.config/nvim
ln -snfv ${DOT_DIRECTORY}/init.vim  ${HOME}/.config/nvim/init.vim
ln -snfv ${DOT_DIRECTORY}/dein.toml ${HOME}/.config/nvim/dein.toml

mkdir ${HOME}/.config/nvim/dein
sh ./installer.sh ${HOME}/.config/nvim/dein

cp -r ./colors ${HOME}/.vim/colors
ln -snfv ${HOME}/.vim/colors ${HOME}/.config/nvim/colors

echo "done"
