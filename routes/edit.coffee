mysql = require 'mysql'

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

  db.query 'select * from wine where id = ?', req.params.id, (err, rows) ->
    throwif err
    res.render 'edit.jade', rows[0], (err, html) ->
      throwif err
      res.send html

exports.post = (req, res) ->
  console.log 'body', req.body
  q = db.query 'update wine set ? where id = ?', [req.body, req.params.id], (err, rows) ->
    throwif err
    res.redirect '/'
  console.log 'query', q
