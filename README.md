# Table of contents

- [Download App](#download-app)
- [System dependencies](#system-dependencies)
- - [First time installing PostGreSQL?](#first-time-installing-psql)
- [Set up App](#set-up-app)

---
## Download App

```bash
git clone https://github.com/LuisEd2094/AmenitizRails
```
---

## System dependencies

- Ruby [First time installing Ruby?]
- Rails
- PostgreSQL [First time installing PSQL?](#install-psql)

---

### Install Ruby

```bash
sudo apt-get install ruby-full
```


### Install PSQL

We will need to install postgresql to the system, create a Database with in it for our user and grant permissions to our to be able to create tables.

```bash
sudo apt install postgresql -y
```
```bash
sudo -i -u postgres
```

Replace new_password with your password of choice and user with your user.

You can run 
```bash
echo $USER
```
on your terminal if you want know your user name.

---
###### Optional 

Since you are here, you can change the postgres user's password to able to connect to psql with 

```bash
psql -U postgres 
```
in the future.
```bash
ALTER USER postgres PASSWORD 'new_password';
```
---

```bash
CREATE USER user WITH PASSWORD 'new_password';

CREATE DATABASE user;

ALTER USER user CREATEDB;

ALTER USER user WITH SUPERUSER;

exit
```

## Set up App

```bash
cd route/to/folder/app
```
```bash
#!/bin/bash
sudo gem install rails
sudo gem install bundler #(might need to use sudo )
sudo bundler install #(might need sudo)
```

```bash
rails db:create && rails db:migrate && rails db:seed
```

```bash
rails s
```

Open http://127.0.0.1:3000 in your web browser.