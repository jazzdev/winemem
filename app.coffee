express = require 'express'
http = require 'http'
path = require 'path'
require 'express-resource'

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

app.resource(require('./controllers/wine'))

http.createServer(app).listen app.get('port'), () ->
  console.log "Express server listening on port " + app.get 'port'
