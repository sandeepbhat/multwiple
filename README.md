multwiple.com is a web-based twitter client that allows you to use multiple twitter accounts.
(http://www.multwiple.com)

Helping out with multwiple.com
-------------------------------

To contribute, get started with the following:

- [Look at the code][code]
- Please fork the project and make a pull request
- Pull requests will not be merged without documentation

[code]: http://github.com/spundhan/multwiple

Setting up a dev environment
----------------------------

First off: you will need Postgresql DB, Sun JDK and ant install along with the usual build-essentials. 
On a debian clone, the following will install them:

    $ sudo apt-get install postgresql postgresql-client pgadmin3 sun-java6-jdk ant 

Setup postgresql DB settings:

    $ sudo -u postgres psql template1
    postgre=# ALTER USER postgres PASSWORD '<your password>';
    postgre=# \q

Now add the following line at the end of the file /etc/postgresql/8.4/main/pg_hba.conf:

    host     all     all     127.0.0.1       255.255.255.0      password


Setup multwiple user for postgresql DB:

    $ sudo -u postgres psql template1
    postgre=# CREATE USER mtwiple_user PASSWORD 'yl4FUS456yD3FIghq';
    postgre=# \q

Then checkout the code:

    $ git clone https://github.com/$MY_GITHUB_USERNAME/multwiple.git

Then create DB for multwiple:

    $ cd multwiple/db
    $ ./restore.sh

Then do:

    $ cd multwiple
    $ make webrun DEBUG=1 # for debug mode

Now visit http://localhost:8080 in your browser (preferably firefox 3.5+) to check it out!
Happy multwiping!!

