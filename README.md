## SS-Panel-Rails

A copy of [ss-panel](https://github.com/orvice/ss-panel) written in Ruby on Rails. Theme by [SB Admin 2 Theme](http://startbootstrap.com/template-overviews/sb-admin-2/)

### ScreenShots

![alt tag](https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/public/index.png)

### Requirements

* Ruby 2.2+
* Rails 5.0+
* Mysql
* Redis

### Installation

#### 1. Install needed dependencies

If you are new to ruby or rails, `One step setup` shell script was provided to install needed dependencies.

* Note: This script only support Centos, Ubuntu and Mac OSX.

Open your shell and type

```shell

$ curl -Ssl https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/setup.sh | sh

```

* Now you should check [#2](#2-create-databaseyml) and [#3](#3-config-your-application) for how to start the application.

#### 2. Create database.yml

For security consideration, the `database.yml` was not on version control, so you should create one.
An example file named `database.yml.example` was provided, rename it and change some important information(eg: account,password,database)

```shell

$ mv config/database.yml.example config/database.yml

```

#### 3. Config your application

* Notice: 
   All private settings are stored in file `config/settings.local.yml`. Create a file `settings.local.yml` in directory `ss-panel-rails/config` and add the following smtp settings

```ruby

mailer: :mailgun # set to :smtp if you don't use mailgun
email_sender: "noreply@example.com" # default send from

# mailgun setting
mailgun_api_key: "you mailgun api key"
mailgun_domain: "you mailgun domain"
mailgun_password: "mailgun smtp setting password"
mailgun_user_name: "username of mailgun smtp"

# string for avatar URI Obfuscation
hash_secret: "hash-secret-for-paperclip"

# Enable invited code feature `( true for enable )`
invited_code: false

```

* Regeister a mailgun account [here](http://www.mailgun.com) if you use mailgun to send email

#### 4. Load database schema 

```shell

$ bundle exec rake db:schema:load
$ bundle exec rake db:seed    # this will create an admin account whose name is `admin@example.org`(you can always change it in db/seed.rb)

```

#### 5. Sidekiq as actionjob adapter

This repo uses `Action Cable` to implement chat module and [sidekiq](https://github.com/mperham/sidekiq) for message relay job, so you should run `bundle exec sidekiq` to get activejob runs.

### Time to playaround

Go to app root directory and type:

```shell

$ rails s

```
open browser and visit [http://localhost:3000](http://localhost:3000)

### Contribute

* fork the repository
* add new features and commit
* pull request

### Wiki
See how to integrate you rails using nginx and puma [wiki](https://github.com/timlentse/ss-panel-rails/wiki)

### LICENSE
MIT
