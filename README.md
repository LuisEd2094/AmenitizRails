# Table of contents

- [Download App](#download-app)
- [System dependencies](#system-dependencies)
- - [First time installing Ruby?](#install-ruby)
- - [First time installing PostGreSQL?](#first-time-installing-psql)
- [Set up App](#set-up-app)

---
## Download App

Clone this repository to your location of choice.

```bash
git clone https://github.com/LuisEd2094/AmenitizRails
```
---

## System dependencies

- Ruby [First time installing Ruby?](#install-ruby)
- Ruby on Rails
- PostgreSQL [First time installing PSQL?](#install-psql)

---



## Set up App

First, we need to go where we downloaded our app. If you cloned the repo without indicating a folder, it'd probably be in a folder called AmenitizRails. 

Run

```bash
cd route/to/folder/app
```

to navigate to the correct folder. Then run this bash script: 
```bash
#!/bin/bash
sudo gem install rails
sudo gem install bundler
sudo bundler install
```

this will install all the gems you'd need.

Then run:

```bash
rails db:create && rails db:migrate && rails db:seed
```

this will create the databases we will be using for dev and testing and populate the dev database. 

You can check the datapoints created in our ```config/seeds.rb``` file. You can add or remove to this file if you want to change anything.

Finally, start the server running ```rails s``` or ```rails server``` at the root of our folder and then open http://127.0.0.1:3000 in your web browser.


---
##### Optional

If your database requires a password to connect, you can add it to your env variables. 

The App will try to read the password PG_PASSWORD, which you can modify in the database.yml file located in 

```bash
config/database.yml
```

You can either modify the env variable used by changing it's name on this line:

```bash
password : <%= ENV['PG_PASSWORD'] %>
```

changing PG_PASSWORD to the variable with your passowrd or you can create a PG_PASSWORD with

```bash
export PG_PASSWORD=yourpassword
```

replacing yourpassword with your database password.

You can modify your ```~/.bashrc``` file by adding 

```bash
export PG_PASSWORD=yourpassword
```
to the end of it so that it bash loads your password correctly everytime you run the terminal.

---
### Install Ruby

```bash
sudo apt-get install ruby-full
```


### Install PSQL

We will need to install PostgreSQL to the system, create a Database in it for our user and grant permissions to our user to be able to create tables.

```bash
sudo apt install postgresql -y
```
```bash
sudo -i -u postgres
```



---
###### Optional 

Since you are here, you can change the postgres user's password to be able to connect to psql directly as postgres user
in the future.

```bash
ALTER USER postgres PASSWORD 'new_password';
```
---

Replace new_password with your password of choice and user with your user.

You can run 
```bash
echo $USER
```
on your terminal if you want to know your user name.

Running these will create our user, create a database for our user and grant our user the permissions it'd need. 

```bash
CREATE USER user WITH PASSWORD 'new_password';

CREATE DATABASE user;

ALTER USER user CREATEDB;

ALTER USER user WITH SUPERUSER;

exit
```

This will exit the database, you can run exit again to close the terminal. 