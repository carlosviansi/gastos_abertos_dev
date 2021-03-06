#!/usr/bin/env bash

read -p "Enter your git user name: " git_name
read -p "Enter your git user email: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

git config --global color.ui true
git config --global core.editor vim

echo -e '\n'
echo 'Generating ssh keys...'
mkdir ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/github_rsa
ssh-add github_rsa

cat <<EOF >> ~/.ssh/config

Host github.com
  Hostname github.com
  IdentityFile ~/.ssh/github_rsa

EOF

echo -e '\n'
echo 'Add the following public key to your Github account (https://github.com/settings/ssh)'
echo -e '\n'
cat /home/vagrant/.ssh/github_rsa.pub
echo -e '\n'
read -p "Press Enter to continue."

echo 'Cloning repositories...'
mkdir /vagrant/repos
git clone git@github.com:okfn-brasil/gastos_abertos.git /vagrant/repos/gastos_abertos
git clone git@github.com:okfn-brasil/gastos_abertos_website.git /vagrant/repos/gastos_abertos_website
git clone git@github.com:okfn-brasil/gastos_abertos_dados.git /vagrant/repos/gastos_abertos_dados
git clone git@github.com:okfn-brasil/gastos_abertos_blog.git /vagrant/repos/gastos_abertos_blog

ln -s /vagrant/repos/gastos_abertos ~/gastos_abertos
ln -s /vagrant/repos/gastos_abertos_website ~/gastos_abertos_website
ln -s /vagrant/repos/gastos_abertos_dados ~/gastos_abertos_dados
ln -s /vagrant/repos/gastos_abertos_blog ~/gastos_abertos_blog
