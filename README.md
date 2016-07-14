# README

# create databases

    run the following in the command line:
    $ psql -d postgres -U <username> -f scripts/create_database_products.sql

# create tables

    $ sequel -m migrations postgres://<username>:<password>@localhost/products_development
    $ sequel -m migrations postgres://<username>:<password>@localhost/products_test
