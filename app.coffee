express = require 'express'
http = require 'http'
path = require 'path'
routes =
  home: require './routes/home'
  add:  require './routes/add'
  edit: require './routes/edit'

app = express()

app.configure () ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', require('jade').__express
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require('stylus').middleware(__dirname + '/public')
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', () ->
  app.use express.errorHandler()

app.get '/', routes.home.get
app.post '/add', routes.add.post
app.get '/edit/:id', routes.edit.get
app.post '/edit/:id', routes.edit.post

http.createServer(app).listen app.get('port'), () ->
  console.log "Express server listening on port " + app.get 'port'
