fs = require 'fs'

module.exports =
  clean_indent: (input) ->
    count = 0
    for character in input
      if character == ' '
        count++
      else
        break
    for i in [1..count]
      input = input.replace(/^ /gm, '')
    return input

  clean_newline: (input) ->
    return input.replace(/^\n*/gm, '')

  clean_whitespace: (input) ->
    return @clean_indent @clean_newline input

  export: (name, extension, input) ->
    path = __dirname + '/export/' + name + '.' + extension
    return fs.writeFile path, @clean_whitespace(input), (err) ->
      throw err if err

  process: (input) ->
    language_array = ['coffee', 'scss', 'sass', 'jade']
    input = input.toString()
    index_array = []
    for language in language_array
      selector = '@' + language
      index = input.indexOf(selector)
      if index != -1
        index_array.push(index) if index != 0
        index_array.push(index + selector.length)
    for index_from, i in index_array by 2
      index_to = index_array[i + 1]
      if index_to
        output = input.slice(index_from, index_to)
        @export('index' + i, 'txt', output)
      else
        output = input.slice(index_from)
        @export('index' + i, 'txt', output)
    return ''
