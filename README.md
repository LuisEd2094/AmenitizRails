# Table of contents

- [Description](#description)
- [Download App](#download-app)
- [System dependencies](#system-dependencies)
- - [First time installing Ruby?](#install-ruby)
- - [First time installing PostGreSQL?](#install-psql)
- - [First time installing React?](#install-react)
- [Set up App](#set-up-app)
- - [Bundle](#bundle)
- - [Database](#database)
- - [Running the server](#running-the-server)
- [Testing](#testing)
- [Common Installation Errors](#common-installation-errors)
---

# Description

This fullstack App is designed to work as a simple shopping cart that you can run on a web browser.

It uses Ruby on Rails to handle the back-end calculations and database interactions. 
PostgreSQL is our relational database.
And we use React to handle our front-end needs.


Once the server is started, the app becomes available at our localhost:3000/ address, where it'll load all the products available in ```products``` table, some of which may have promotions available in ```promotions``` table. 

The user will be able to increase or decrease the quantity of products to shop, and once ```Add to cart``` is clicked, it'll call our back-end to get the final price of their purchase, including any discounts any product may have.

It's able to handle two types of discounts at the moment, what I call ```EQUAL``` or ```GREATER``` discounts.

```EQUAL```: these promotions apply each time a quantity-of-items condition is met. They are your ```2x1``` and ```3x2``` types. 

```GREATER```: these are your ```After the third unit, you get a 10% discount for all of them``` types. It'll check if the minimum number of items is met and apply the discount to all those items in the cart. 


Once the calculation is done, it'll send back a json response which React will consume to update the page the user is on.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---

## System dependencies

- Ruby [First time installing Ruby?](#install-ruby)
- React [First time installing React?](#install-react)
- Ruby on Rails
- PostgreSQL [First time installing PSQL?](#install-psql)
- Ubuntu

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

#### Bundle

Now we need to use bundle to install our gems. By default, it'll try to install them at /var/lib/gems. You may or may not have access to this folder with your current user. 

There are a few options you might try. You can do:

```bash
bundle config set path './vendor/bundle'
```

this will configure your bundle to use the path at ```./vendor/bundle``` to store and check your gems at the root of the repo you cloned.

Or you can instead change the path where bundler installs gems, for example to your user's home directory, running something like this:

```bash
export GEM_HOME="$HOME/.gems"
export PATH="$GEM_HOME/bin:$PATH"
```

I'd suggest the first option. Either way, after you have done any of them, you can run:


```bash
bundler install
```


You can also simply run it as sudo, but this might cause issues for other users on the system if they try to run the app:

```bash
sudo bundler install
```


Once this is done, you'll have all the gems you need to run the app.


#### Database

For our next step, we need to set up our databases and tables. We can let rails handle it by running: 


```bash
rails db:create && rails db:migrate && rails db:seed
```

this will create the databases we will be using for dev and testing and populate the dev database. 

You can check the datapoints created in the ```db/seeds.rb``` file. You can add or remove from this file if you want to change anything.

#### Running the server

Finally, start the server running ```rails s``` or ```rails server``` at the root of our repo and then open http://127.0.0.1:3000 in your web browser.

And that's it! You should see all the products that were loaded to our database, and you can now start adding products to the cart!

<font size="1"> [Back to Table of contents](#table-of-contents) </font>


---
##### Optional

If your database requires a password to connect, you can add it to your env variables. 

The App will try to read the password PG_PASSWORD.

You can set up the app to use your database's password by doing any of the following:

- If you are not storing your database's password in a env variable you can create it with: 

```bash
export PG_PASSWORD=yourpassword
```

- Modifying the database.yml file located in ```config/database.yml``` and searching for the line:  
```bash
password : <%= ENV['PG_PASSWORD'] %>
```

Either way, Rails will use your password to connect to the database automatically.

If you haven't done so already, you can modify your ```~/.bashrc``` file by adding 

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

at the root of the repo and it'll automatically run all the tests located at ```test/```.

You can run a specific test if you add the file name at the end of the command. 

For example: 

```bash
rails test test/models/product_test.rb
```

will run all the tests for the model ```product```.

<font size="1"> [Back to Table of contents](#table-of-contents) </font>

### Install Ruby

We are using Ruby 3.0.2, you can run this to install it:

```bash
sudo apt install ruby-full -y
```
<font size="1"> [Back to Table of contents](#table-of-contents) </font>

---
### Install PSQL

We will need to install PostgreSQL on the system, create a Database in it for our user and grant permissions to our user to be able to create tables.

You will need to add your user to the server's database, if you don't know your user you can run 
 
```bash
echo $USER
```

and it'll print the current user's name.

To install PostgreSQL:
```bash
sudo apt install postgresql -y
sudo apt install libpq-dev -y
```
Since it's a new installation, if we try to run ```psql``` it'll ask for a password that has not been set up. So we can run the following command to change our user on the terminal to postgres, which will allow us  to connect to our Postgre server.
```bash
sudo -i -u postgres
```

Then run:
```bash
psql
```

And now we are inside our server!

It's time to create our user, its database and give the proper roles to it.

Make sure to replace "user" and "new_password" with your user and password, respectively.

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

While you are here, you can change the postgres user's password to be able to connect to psql directly as postgres user in the future. Just run:

```bash
ALTER USER postgres PASSWORD 'new_password';
```

to update postgres password.

---


That's it! You can close the terminal now or type ```exit``` once to exit the server and ```exit``` again to leave our postgres' terminal session. 

<font size="1"> [Back to Table of contents](#table-of-contents) </font>


### Install React 

If you haven't installed node in your system, you will need to install it along side the gem. Run:

```bash
sudo apt install nodejs -y
```

<font size="1"> [Back to Table of contents](#table-of-contents) </font>


### Common Installation Errors

You might need to upgrade your system to get everything working.

Run:

```bash
sudo apt update && sudo apt upgrade
sudo apt install -y  build-essential
```

You will need to have yaml libs installed, if you haven't you can run:

```bash
sudo apt install libyaml-dev libpython2.7-dev
```

Some first time users of Ruby have reported that they need to run:

```bash
sudo bundle install
```

at the root of the repository, then clone the repo again, and then run:

```bash
bundle config set path './vendor/bundle'
bundle install
```

at the root of the repo.



<font size="1"> [Back to Table of contents](#table-of-contents) </font>

