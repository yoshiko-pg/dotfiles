#! /bin/sh
cd `dirname $0`
DOT_DIRECTORY=`pwd`

for f in .??*
do
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo -e "\e[32mDeploy dotfiles complete!\e[m"
