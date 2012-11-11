mysql = require 'mysql'
require 'sugar' # for date formatting

db = mysql.createConnection
  host: 'localhost',
  user: 'winemem',
  password: 'drinkup',
  database: 'winemem'

throwif = (err) ->
  throw err if err

exports.index = (req, res) ->
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

exports.create = (req, res) ->
  if not db.connected?
    db.connect (err) ->
      throwif err
      console.log 'DB Connected'
      db.connected = true

  grape = req.body.name.match /(Merlot|Cab||Zin|Tempranillo|Syrah|Shiraz|Malbec)/i
  if grape?
    req.body.grape = grape[1]
    req.body.color = 'red'
  grape = req.body.name.match /(Pinot Gris|Pinot Grigio|Riesling|Chenin Blanc)/i
  if grape?
    req.body.grape = grape[1]
    req.body.color = 'white'
  color = req.body.name.match /\b(red|white)\b/i
  if color?
    req.body.color = color[1]

  db.query 'insert into wine set ?', req.body, (err) ->
    throwif err
    res.redirect '/'

exports.edit = (req, res) ->
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

exports.update = (req, res) ->
  db.query 'update wine set ? where id = ?', [req.body, req.params.id], (err) ->
    throwif err
    res.redirect '/'
