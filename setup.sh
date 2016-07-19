#! /bin/sh
plantform_name=$(python -mplatform | tr '[:upper:]' '[:lower:]') 

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
  redis_dir_name=/usr/local/redis-3.2.0
  echo "Install redis by compiling from source code...\n
  version: 3.2.0\n"
  if [ -d "$redis_dir_name" ];then
    echo "Already Downloaded!"
  else
    wget "http://download.redis.io/releases/redis-3.2.0.tar.gz"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  fi
  cd "$redis_dir_name"
  make 
  make install
  cd 
}

# Install ruby by compiling source code

install_ruby(){
  ruby_dir_name="ruby-2.3.1"
  echo "Install ruby by compiling from source code...\n
  version: 2.3.1\n"
  if [ -d "$ruby_dir_name" ];then
    echo "Already downloaded!"
  else
    wget "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
    tar -xzvf ruby-2.3.1.tar.gz
  fi
  cd $ruby_dir_name
  ./configure
  make 
  make install
  cd 
}

# Install some important gems when ruby is ready

install_gems(){
  sudo gem install bundler rails
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
      apt-get update
      apt-get -y install build-essential
      apt-get -y install git nginx mysql-client mysql-server libmysql++-dev libmysqlclient-dev libmysql++3
      apt-get -y install imagemagick libmagick++-dev
      install_redis
      apt-get -y install openssl libssl-dev
      # for js runtime 
      apt-get -y install nodejs
      install_ruby
      install_gems
      ;;
    'centos')
      yum update
      yum -y install git nginx mysql-client mysql-server ImageMagick ImageMagick-c++-devel 
      install_redis
      yum -y install openssl openssl-devel
      yum -y install nodejs
      install_gems
      ;;
  esac
}

install_stuff
