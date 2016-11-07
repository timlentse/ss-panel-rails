## SS-Rails-Panel

A Ruby on Rails copy of [ss-panel](https://github.com/orvice/ss-panel). Theme by [SB Admin 2 Theme](http://startbootstrap.com/template-overviews/sb-admin-2/)

### ScreenShots
![alt tag](https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/public/home.png)
![alt tag](https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/public/index.png)

### Requirements
* Ruby 2.2+
* Rails 4.2+
* Mysql
* Redis

### Installation

#### 1. Install needed dependencies

If you are new to ruby or rails, `One step setup` shell script was provided to install needed dependencies.

Open your shell and type

```shell
$ curl -Ssl https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/setup.sh | sh
```

* Now you should check [#2](#2-create-databaseyml) and [#3](#3-config-your-application) for how to make it works.

Go to ss-panel-rails and type `rails s`

Open browser and visit `http://localhost:3000`


#### 2. Create database.yml

For security consideration, the `database.yml` was not put in version control, so we should create one.
We had provided an example file, rename it and change some important information(mysql account,password,etc)

```shell
$ mv config/database.yml.example config/database.yml
```

#### 3. Config your application
* Notice: 
All private setting are stored in file `config/settings.local.yml`. Create a file `settings.local.yml` in directory `ss-panel-rails/config` and add the following for smtp setting
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
$ bundle exec rake db:seed    # this will create an admin account whose account_name is `admin@example.org`(you can change it in db/seed.rb)
```
#### 5. Sidekiq as the actionjob adapter

This repo uses actioncable for chat and sidekiq for message relay job, so you should run `bundle exec sidekiq` to get activejob runs.

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
