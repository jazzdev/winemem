mysql = require 'mysql'
require 'sugar' # for date formatting

db = mysql.createConnection
  host: 'localhost',
  user: 'winemem',
  password: 'drinkup',
  database: 'winemem'

throwif = (err) ->
  throw err if err

exports.get = (req, res) ->
  if not db.connected?
    db.connect (err) ->
      throwif err
      console.log 'DB Connected'
      db.connected = true

  db.query 'select * from wine order by date_added desc', (err, rows) ->
    throwif err
    console.log "DB return #{rows.length} rows"
    res.render 'home.jade',
      wines: rows,
      pretty: true
    , (err, html) ->
      throwif err
      res.send html
