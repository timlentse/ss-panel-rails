### README
This is a rails copy of [ss-panel](https://github.com/orvice/ss-panel). Powered by [SB Admin 2 Theme](http://startbootstrap.com/template-overviews/sb-admin-2/)
### Requirements
* ruby 2.2+
* rails 4.2+
* mysql
* redis

### Install

#### 1.clone repository

```shell
$ git clone git@github.com:timlentse/ss-panel-rails.git
```
#### 2.install gems

```shell
$ cd ss-panel-rails
$ bundle install --path=vendor/bundle
```
#### 3.load database and tables
import sql file in `connfig/db_init.sql`  to mysql

```sql
mysql> source `absolute path of db_init.sql `;
```
#### some configuration
* Notice: All private setting are stored in file `config/setting.local.yml`
create a file `setting.local.yml` in directory `config`
and add :
```ruby
# mailgun setting
mailgun_api_key: "you mailgun api key"
mailgun_domain: "you mailgun domain"
mailgun_sender: "set a sender"
mailgun_password: "mailgun smtp setting password"
mailgun_user_name: "username of mailgun smtp"
```
### Time to playaround
Go to app root directory and type:
```shell
$ rails s

```
### LICENSE
MIT
