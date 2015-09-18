fs = require 'fs'
path = require 'path'
os = require 'os'

packageJson = require './package.json'

module.exports = (grunt) ->
  appName = "#{packageJson.name}.app"
  [major, minor, patch] = packageJson.version.split('.')

  if process.platform is 'darwin'
    atomAppDir = path.join('atom-shell', 'Atom.app', 'Contents', 'Resources', 'app')
  else
    atomAppDir = path.join('atom-shell', 'resources', 'app')

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    symlink:
      app:
        link: atomAppDir
        target: path.join('..', '..', '..', '..', 'app')
        options:
          type: 'dir'
          force: true
          overwrite: true

    'download-electron':
      version: packageJson.atomShellVersion
      outputDir: path.join('electron')
      downloadDir: path.join(os.tmpdir(), 'downloaded-electron')
      rebuild: true  # rebuild native modules after atom-shell is updated

    shell:
      'app-apm-install':
        options:
          stdout: true
          stderr: true
          failOnError: true
          execOptions:
            cwd: 'app'
        command: 'apm install'

    copy:
      app:
        files: [
        ]

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-symbolic-link')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-download-electron')
  grunt.loadTasks('tasks')

  grunt.registerTask('bootstrap', ['grunt-download-electron', 'symlink:app', 'generate-plist', 'shell:app-apm-install'])
  grunt.registerTask('bootstrap-win', ['download-electron', 'shell:app-apm-install'])
  grunt.registerTask('build', ['grunt-download-electron', 'shell:app-apm-install', 'copy:app', 'generate-plist'])
