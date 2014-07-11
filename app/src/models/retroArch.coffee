_ = require 'underscore'
Spine._ = require 'underscore'

path = require 'path'

os = require 'os'
shell = require 'shell'

class RetroArch extends Spine.Model
  @configure "RetroArch"

  constructor: ->
    super
    @games = []
    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed

  launchGame: (game) ->
    switch os.platform()
      when "darwin"
        if game.gameConsole.prefix == "mac"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'bin', 'retroarch')
      when "win32"
        if game.gameConsole.prefix == "pc"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'retroarch.exe')
      else
        alert("Sorry, this operating system isn't supported.")
        return

    if game.gameConsole.prefix != "pc" && game.gameConsole.prefix != "mac"
      configPath = path.join(__dirname, '..', '..', 'configs')
      options = ["--config", path.join(configPath, os.platform(), 'kart.cfg'),
           "--appendconfig", path.join(configPath, os.platform(), "#{game.gameConsole.prefix}.cfg"),
           path.normalize(game.filePath)]

    @recentlyPlayed.addGame(game)

    console.log(command)
    console.log(options)

    if options
      {spawn} = require 'child_process'
      ls = spawn command, options
      # receive all output and process
      ls.stdout.on 'data', (data) -> console.log data.toString().trim()
      # receive error messages and process
      ls.stderr.on 'data', (data) -> console.log data.toString().trim()
    else
      shell.openItem(game.filePath);


module.exports = RetroArch
