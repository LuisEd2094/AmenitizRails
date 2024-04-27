# Table of contents

- [Description](#description)
- [Download App](#download-app)
- [System dependencies](#system-dependencies)
- - [First time installing Ruby?](#install-ruby)
- - [First time installing PostGreSQL?](#install-psql)
- [Set up App](#set-up-app)
- [Testing](#testing)
---

# Description

This fullstack App is designed to work as a simple shopping cart that you can run on a web browser.

It uses Ruby on Rails to handle the back-end calculations and database interactions. 
PostgreSQL is our relational database.
And we use React to handle our front-end needs.


Once the server is started, the app becomes available at our localhost:3000/ address, where it'd load all the products available on our ```products``` database, some of which may have promotions available at ```promotions``` database. 

The user will be able to increase or decrease the quantity of products to shop, and once ```Add to cart``` is clicked, it'd call our back-end to get the final price of our purchase, including any discounts any product may have.

It's able to handle two types of discounts at the moment, what I call ```EQUAL``` or ```GREATER``` discounts.

```EQUAL```: these promotions apply each time a number of items condition is met. They are your ```2x1``` and ```3x2``` types. 

```GREATER```: these are your ```After the third unit, you get a 10% discount for all of them``` types. It'd check if the minimum number of items is met and apply the discount to all those items in the cart. 


Once the calculation is done, it'd send back a json response which React will consume to update the page the user is on.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---

## System dependencies

- Ruby [First time installing Ruby?](#install-ruby)
- Ruby on Rails
- PostgreSQL [First time installing PSQL?](#install-psql)

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---

## Download App

Clone this repository to your location of choice.

```bash
git clone https://github.com/LuisEd2094/AmenitizRails
```

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---


## Set up App

First, we need to go where we downloaded our app. If you cloned the repo without indicating a folder, it'd probably be in a folder called AmenitizRails, so you can run: 

Run

```bash
cd AmenitizRails
```

Once inside our folder run this bash script: 
```bash
#!/bin/bash
sudo gem install rails
sudo gem install bundler
```

Now we need to use bundle to install our gems. By default, it'd try to install them at /var/lib/gems. You may or may not have access to this folder with your current user. 

There are two options you might try. You can do:

```bash
sudo bundler install
```
or you can instead change the path where bundler installs gems, for example to your user's home directory, running something like this:

```bash
export GEM_HOME="$HOME/.gems"
export PATH="$GEM_HOME/bin:$PATH"
```

and then run 

```bash
bundler install
```


This will install all the gems you'd need.

After this, we need to set up our databases. We can let rails handle it running: 


```bash
rails db:create && rails db:migrate && rails db:seed
```

this will create the databases we will be using for dev and testing and populate the dev database. 

You can check the datapoints created in our ```db/seeds.rb``` file. You can add or remove to this file if you want to change anything.

Finally, start the server running ```rails s``` or ```rails server``` at the root of our folder and then open http://127.0.0.1:3000 in your web browser.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>


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

changing PG_PASSWORD to the variable with your password or you can create a PG_PASSWORD with

```bash
export PG_PASSWORD=yourpassword
```

replacing yourpassword with your database password.

You can modify your ```~/.bashrc``` file by adding 

```bash
export PG_PASSWORD=yourpassword
```
to the end of it so that bash loads your password correctly everytime you run a new terminal.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---

### Testing

You can simply run 
```bash
rails test
```

at the root of the repo and it'd automatically run all the tests located at ```test/```.

You can run a specific test if you add the file name at the end of the command, 

```bash
rails test test/models/product_test.rb
```

will run all the test for the model ```product```.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

### Install Ruby

We are using Ruby 3.0.2, you can run this in the root of our app to install it

```bash
sudo apt install ruby-full -y
```
<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---
### Install PSQL

We will need to install PostgreSQL to the system, create a Database in it for our user and grant permissions to our user to be able to create tables.

You will need to add your user to the server's database, if you don't know your user you can run 
 
```bash
echo $USER
```

and it'd print the current user's name.

To install PostgreSQL:
```bash
sudo apt install postgresql -y
```
Since it's a new installation, if we try to run ```psql``` it'd ask for a password that has not been set up. So we can run the following command to change our user on the terminal to postgres, which will allow us  to connect to our Postgre server.
```bash
sudo -i -u postgres
```

Then run:
```bash
psql
```

And now we are inside our server!

Now we need to create our user, its database and give the proper roles to it.

Make sure to replacer "user" and "new_password" with your user and password, respectively.

Create user: 

```bash
CREATE USER user WITH PASSWORD 'new_password';
```

Create it's own database:

```bash
CREATE DATABASE user;
```

Give our new user the neccesary roles:

```bash
ALTER USER user CREATEDB;

ALTER USER user WITH SUPERUSER;
```

---
###### Optional 

Since you are here, you can change the postgres user's password to be able to connect to psql directly as postgres user in the future. Just run:

```bash
ALTER USER postgres PASSWORD 'new_password';
```
---

That's it! You can close the terminal now or type ```exit``` once to exit the server and ```exit``` again to leave our postgre's terminal session. 

<font size="1"> [Back to Table of contents](#table-of-contents) </font>
