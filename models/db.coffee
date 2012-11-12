mysql = require 'mysql'

class DB
  constructor: () ->
    @db = mysql.createConnection
      host: 'localhost',
      user: 'winemem',
      password: 'drinkup',
      database: 'winemem'
    @db.connect (err) ->
      throwif err
      console.log 'DB Connected'

  query: (args...) ->
    @db.query.apply @db, args

module.exports = new DB()

throwif = (err) ->
  throw err if err
