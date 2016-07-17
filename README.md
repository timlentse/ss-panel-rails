### README
This is a rails copy of [ss-panel](https://github.com/orvice/ss-panel). Theme by [SB Admin 2 Theme](http://startbootstrap.com/template-overviews/sb-admin-2/)

### ScreenShots
![alt tag](https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/public/home.png)
![alt tag](https://raw.githubusercontent.com/timlentse/ss-panel-rails/master/public/index.png)
### Requirements
* ruby 2.2+
* rails 4.2+
* mysql
* redis

### Install

#### 1. clone repository

```shell
$ git clone git@github.com:timlentse/ss-panel-rails.git
```
#### 2. install gems

Your machine should have `ruby` installed. If not, see [here](https://www.ruby-lang.org/en/) for installation guide.

Once `ruby` installed. type:

```shell
$ sudo gem install bundler
```

In repository root directory, type the following to install dependencies.

```shell
# run this command under 'ss-panel-rails'

$ bundle install --path=vendor/bundle
```

#### 3. load database and tables
We use `mysql` as database for rails. Import sql file in `connfig/db_init.sql`  to mysql

```sql
mysql> source `absolute path of db_init.sql `;
```

#### 4. create database.yml

For security consideration, the `database.yml` was not put in version control, so we should create one.

```shell
$ vi config/database.yml
```

* paste the following

```ruby

default: &default
  adapter: mysql2
  pool: 5
  timeout: 5000
  database: 'sspanel_db'
  host: 'localhost'

# In development environment
development:
  <<: *default
  username: "your mysql username"
  password: "your mysql password"

# In production environment
production:
  <<: *default
  username: "your mysql username"
  password: "your mysql password"
```

#### 5. some configuration
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
invited_code: true
```
* regeister a mailgun account [here](http://www.mailgun.com) if you use mailgun to send email

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

### wiki
see how to integrate you rails using nginx and puma [wiki](https://github.com/timlentse/ss-panel-rails/wiki)

### LICENSE
MIT
