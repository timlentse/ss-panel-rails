### README
This is a rails copy of [ss-panel](https://github.com/orvice/ss-panel). Powered by [SB Admin 2 Theme](http://startbootstrap.com/template-overviews/sb-admin-2/)
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

```shell
$ cd ss-panel-rails
$ bundle install --path=vendor/bundle
```
#### 3. load database and tables
import sql file in `connfig/db_init.sql`  to mysql

```sql
mysql> source `absolute path of db_init.sql `;
```
#### 4. some configuration
* Notice: 
All private setting are stored in file `config/settings.local.yml` create a file `settings.local.yml` in directory `ss-panel-rails/config` and add the following for smtp setting
```ruby
mailer: :mailgun # set to :smtp if you don't use mailgun
email_sender: "OpenMind@ss.tan90.cn" # default send from
# mailgun setting
mailgun_api_key: "you mailgun api key"
mailgun_domain: "you mailgun domain"
mailgun_password: "mailgun smtp setting password"
mailgun_user_name: "username of mailgun smtp"
```
* regeister a mailgun account [here](http://www.mailgun.com) if you use mailgun to send email
### Time to playaround
Go to app root directory and type:
```shell
$ rails s
```
open browser and visit [http://localhost:3000](http://localhost:3000)

### wiki
see how to integrate you rails using nginx and puma [wiki](https://github.com/timlentse/ss-panel-rails/wiki)

### LICENSE
MIT
