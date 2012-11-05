mysql = require 'mysql'

db = mysql.createConnection
  host: 'localhost',
  user: 'winemem',
  password: 'drinkup',
  database: 'winemem'

throwif = (err) ->
  throw err if err

exports.post = (req, res) ->
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
