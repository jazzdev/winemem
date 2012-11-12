db = require '../models/db'
require 'sugar' # for date formatting

throwif = (err) ->
  throw err if err

exports.index = (req, res) ->
  db.query 'select * from wine order by date_added desc', (err, rows) ->
    throwif err
    console.log "DB return #{rows.length} rows"
    res.render 'index.jade',
      wines: rows,
      pretty: true
    , (err, html) ->
      throwif err
      res.send html

exports.create = (req, res) ->
  wine = req.body
  grape = wine.name.match /(merlot|cab|zin|tempranillo|syrah|shiraz|malbec)/i
  console.log 'grape', grape
  if grape?
    wine.grape = grape[1]
    wine.color = 'red'
  grape = wine.name.match /(pinot gris|pinot grigio|riesling|chenin blanc)/i
  if grape?
    wine.grape = grape[1]
    wine.color = 'white'
  color = wine.name.match /\b(red|white)\b/i
  if color?
    wine.color = color[1]

  console.log 'wine', wine
  db.query 'insert into wine set ?', wine, (err) ->
    throwif err
    res.redirect '/'

exports.edit = (req, res) ->
  db.query 'select * from wine where id = ?', req.params.id, (err, rows) ->
    throwif err
    res.render 'edit.jade', rows[0], (err, html) ->
      throwif err
      res.send html

exports.update = (req, res) ->
  db.query 'update wine set ? where id = ?', [req.body, req.params.id], (err) ->
    throwif err
    res.redirect '/'
