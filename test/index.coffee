lasso = require '../'
fs = require 'fs'

fs.readFile __dirname + '/index.lasso', (err, data) ->
  throw err if err

  console.log lasso.process(data)
