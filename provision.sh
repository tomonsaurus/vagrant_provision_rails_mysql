#!/usr/bin/env bash
################################################

echo "**exec user:"
whoami

################################################
echo "**yum install"

sudo yum -y remove ruby
sudo yum -y install git
sudo yum -y install readline-devel.x86_64

sudo yum -y install sqlite-devel
sudo yum -y install gcc-c++
sudo yum -y install patch
sudo yum -y install bind-utils
sudo yum -y install openssl-devel zlib-devel
sudo yum -y install vim

sudo service iptables stop
sudo chkconfig iptables off

################################################
echo "**time"

sudo yum install -y ntp
sudo cp /usr/share/zoneinfo/Japan /etc/localtime
date

sudo chkconfig ntpd on 
sudo service ntpd start

sudo ntpdate -s ntp.nict.jp



################################################
echo "**rbenv"
cd ~
if [[ ! -d $HOME/.rbenv ]]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  cat ~/.bash_profile
  source ~/.bash_profile
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# TODO version place common dir
#http://oogatta.hatenadiary.jp/entry/20131115/1384508584
#$ruby_script = <<SCRIPT
#echo "ruby"
#VERSION=`rbenv versions`
#if [[ ! $VERSION =~ $(< /vagrant/.ruby-version) ]]; then
# rbenv install $(< /vagrant/.ruby-version)
#fi
#SCRIPT


RUBY_INSTALL_VERSION='2.2.3'

echo "**ruby"
VERSION=`rbenv versions`
echo $VERSION
echo $RUBY_INSTALL_VERSION
if [[ ! $VERSION =~ $RUBY_INSTALL_VERSION ]]; then
  echo 'Now, we start to install ruby. you must wait for about 30 minuites.!! long long time.'
    rbenv install $RUBY_INSTALL_VERSION
  rbenv global $RUBY_INSTALL_VERSION
  ruby -v    
    
fi


################################################
echo "**rails install"

echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
rbenv exec gem install bundler

rbenv rehash

echo '
# A sample Gemfile
source "https://rubygems.org"
gem "rails", "4.2.0"'  > Gemfile

bundle install --path vendor/bundle

bundle exec rails new test1 --skip-bundle


#cd ~/test1

# Gemfile
# # gem 'therubyracer', platforms: :ruby comment in 
# bundle install

#bundle exec rails -b 0.0.0.0

#echo "access http://192.168.33.10:3000/test1"

#echo "if you can see the rails default page, rails install has completed"


################################################
echo "**mysql"
sudo yum install -y mysql-server.x86_64
sudo service mysqld start

sudo chkconfig mysqld on

echo "
create database vagrant_test;
use vagrant_test;
grant all on vagrant_test.* to dbuser@localhost identified by 'dbpass';
use vagrant_test;
create table user ( id int key auto_increment, name text, state tinyint );

insert into user values (1,'taro',1),(2,'hanako',1),(3,'tanaka',1),(4,'kimura',0);
" | mysql -u root

echo "**end"


