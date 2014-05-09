fsUtils = require '../lib/fs-utils'
path = require 'path'

_ = require 'underscore'
less = require 'less'
LessCache = require 'less-cache'

cache = new LessCache(cacheDir: path.join(__dirname, '..', 'lesscache'))

# require '../lib/jquery-extensions'
# require '../lib/underscore-extensions'

window.stylesheetElementForId = (id) ->
  $("""head style[id="#{id}"]""")

window.resolveStylesheet = (stylesheetPath) ->
  stylesheetPath = '../styles/' + stylesheetPath

  if path.extname(stylesheetPath).length > 0
    fsUtils.resolveOnLoadPath(stylesheetPath)
  else
    fsUtils.resolveOnLoadPath(stylesheetPath, ['css', 'less'])

window.requireStylesheet = (stylesheetPath) ->
  if fullPath = window.resolveStylesheet(stylesheetPath)
    content = window.loadStylesheet(fullPath)
    window.applyStylesheet(fullPath, content)
  else
    throw new Error("Could not find a file at path '#{stylesheetPath}'")

window.loadStylesheet = (stylesheetPath) ->
  cache.readFileSync stylesheetPath

window.loadLessStylesheet = (lessStylesheetPath) ->
  parser = new less.Parser
    syncImport: true
    #paths: ['../styles/shared', '../styles/mac']
    filename: lessStylesheetPath

  try
    content = null
    parser.parse fsUtils.read(lessStylesheetPath), (e, tree) ->
      throw e if e?
      content = tree.toCSS()
    content
  catch e
    console.error """
      Error compiling less stylesheet: #{lessStylesheetPath}
      Line number: #{e.line}
      #{e.message}
    """

window.removeStylesheet = (stylesheetPath) ->
  stylesheetPath = '../styles/' + stylesheetPath
  unless fullPath = window.resolveStylesheet(stylesheetPath)
    throw new Error("Could not find a file at path '#{stylesheetPath}'")
  window.stylesheetElementForId(fullPath).remove()

window.applyStylesheet = (id, text, ttype = 'bundled') ->
  unless window.stylesheetElementForId(id).length
    if $("head style.#{ttype}").length
      $("head style.#{ttype}:last").after "<style class='#{ttype}' id='#{id}'>#{text}</style>"
    else
      $("head").append "<style class='#{ttype}' id='#{id}'>#{text}</style>"
