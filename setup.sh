gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile

source ~/.bash_profile

gem install bundler

bundle install

rake db:create db:migrate

rails s -b 0.0.0.0 -p 3000