# DB Maker

[![Build Status](https://travis-ci.org/zephinzer/db-maker.svg?branch=master)](https://travis-ci.org/zephinzer/db-maker)

Service for creating new databases in Docker environments. This service exists to overcome the limitations of the MySQL Docker image which can only create a single database. Call this service to provision a new database.

## Usage

See the [docker-compose.yml](./docker-compose.yml) for a simple setup.

### `GET /:clientName/:host/:rootPassword/:databaseName/:databaserUser/:databasePassword`

`clientName` can be either `"mysql"` or `"mysql2"`.

`host` is the hostname of your MySQL database.

`rootPassword` is the root password for the MySQL database.

`databaseName` is the name of the database you wish to create.

`databaseUser` is the user of the database you wish to create.

`databasePassword` is the password for the user specified in `:databaseUser`.

## Service Configuration

This service takes in only a `PORT` environment variable which decides which port the service will listen on. 

## License
This project is licensed under [the MIT license](./LICENSE).

# Cheers
