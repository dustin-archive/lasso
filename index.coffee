fs = require 'fs'

module.exports =
  export: (name, extension, input) ->
    return fs.writeFile __dirname + '/export/' + name + '.' + extension, input, (err) ->
      throw err if err

  process: (input) ->
    languages = ['coffee', 'scss', 'sass', 'jade']
    input = input.toString()
    index_array = []
    for lasso in languages
      selector = '@' + lasso
      index = input.indexOf(selector)
      if index != -1
        index_array.push(index) if index != 0
        index_array.push(index + selector.length)
    for index_from, i in index_array by 2
      index_to = index_array[i + 1]
      if index_to
        output = input.slice(index_from, index_to)
        console.log output
        @export('index' + i, 'txt', output)
      else
        output = input.slice(index_from)
        console.log output
        @export('index' + i, 'txt', output)

    return ''
