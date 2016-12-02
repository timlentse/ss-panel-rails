#! /bin/sh

git clone git@github.com:timlentse/ss-panel-rails.git

plantform_name=$(python -mplatform | tr '[:upper:]' '[:lower:]') 

echo "Your plantform is $plantform_name"

get_distribution_name(){
  case "$plantform_name" in
    *darwin*)
      echo 'mac'
      ;;
    *ubuntu*)
      echo 'ubuntu'
      ;;
    *centos*)
      echo 'centos'
  esac
}

distribution_name=$(get_distribution_name)

# Install redis by compiling source code

install_redis(){
  redis_dir_name="redis-3.2.0"
  echo "Install redis by compiling from source code...\n
  version: 3.2.0\n"
  if [ -f "$redis_dir_name.tar.gz" ];then
    echo "Already Downloaded!"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  else
    wget "http://download.redis.io/releases/redis-3.2.0.tar.gz"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  fi
  cd "/usr/local/$redis_dir_name"
  make 
  sudo make install
  cd 
}

# Install ruby by compiling source code

install_ruby(){
  ruby_dir_name="ruby-2.3.1"
  echo "Install ruby by compiling from source code...\n
  version: 2.3.1\n"
  if [ -f "$ruby_dir_name.tar.gz" ];then
    echo "Already downloaded!"
    tar -xzvf ruby-2.3.1.tar.gz
  else
    wget "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
    tar -xzvf ruby-2.3.1.tar.gz
  fi
  cd $ruby_dir_name
  ./configure
  make 
  sudo make install
  cd 
}

# Install some important gems when ruby is ready

install_gems(){
  sudo gem install bundler rails
}

install_dep(){
  cd ss-panel-rails
  /usr/local/bin/bundle config mirrors.https://rubygems.org/ https://ruby.taobao.org
  /usr/local/bin/bundle install --path=vendor/bundle
}

# Install stuff (git, nginx, mysql, redis, openssl ruby)

install_stuff(){
  case "$distribution_name" in
    'mac')
      brew update
      brew install openssl
      brew install mosh zsh git nginx mysql redis ruby
      brew install nodejs
      install_gems
      ;;
    'ubuntu')
      sudo apt-get update
      sudo apt-get -y install build-essential
      sudo apt-get -y install git nginx mysql-client mysql-server libmysql++-dev libmysqlclient-dev libmysql++3
      sudo apt-get -y install imagemagick libmagick++-dev
      install_redis
      sudo apt-get -y install openssl libssl-dev nodejs
      install_ruby
      install_gems
      ;;
    'centos')
      sudo yum update
      sudo yum -y install git nginx mysql-client mysql-server ImageMagick ImageMagick-c++-devel 
      install_redis
      sudo yum -y install openssl openssl-devel
      sudo yum -y install nodejs
      install_ruby
      install_gems
      ;;
  esac
}

install_stuff
install_dep
