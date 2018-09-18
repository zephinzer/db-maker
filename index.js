const crypto = require('crypto');

const Case = require('case');
const express = require('express');
const knex = require('knex');

const app = express();

app.use('/:clientName/:host/:rootPassword/:databaseName/:databaserUser/:databasePassword', (req, res) => {
  const {
    clientName,
    host,
    rootPassword,
    databaseName,
    databaseUser,
    databasePassword,
  } = req.params;
  const database = knex({
    client: clientName,
    connection: {
      user: 'root',
      password: rootPassword,
      host,
    },
  });
  const dbName = Case.snake(databaseName);
  const dbUser = Case.snake(databaseUser);
  switch(clientName) {
  case 'mysql':
  case 'mysql2':
    database.raw(`CREATE DATABASE IF NOT EXISTS ${dbName} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`)
      .then(() =>
        database.raw(`CREATE USER IF NOT EXISTS '${dbUser}'@'%' IDENTIFIED BY '${databasePassword}'`)
      ).then(() =>
        database.raw(`GRANT ALL ON ${dbName}.* TO '${dbUser}'@'%'`)
      ).then(() => {
        res
          .status(200)
          .json({
            dbName,
            dbUser,
            dbPass: crypto.createHash('md5').update(databasePassword).digest("hex"),
          });
      }).catch((err) => {
        res
          .status(500)
          .json(err);
      });
  break;
  default:
    res
      .status(400)
      .json('invalid client');
  }
});

const server = app.listen(process.env.PORT);
server.on('listening', () => {
  console.info(`Started on http://localhost:${server.address().port}`);
});
