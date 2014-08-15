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

    'download-atom-shell':
      version: packageJson.atomShellVersion
      outputDir: path.join('atom-shell')
      downloadDir: path.join(os.tmpdir(), 'downloaded-atom-shell')
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
  grunt.loadNpmTasks('grunt-download-atom-shell')
  grunt.loadTasks('tasks')

  grunt.registerTask('bootstrap', ['download-atom-shell', 'symlink:app', 'generate-plist', 'shell:app-apm-install'])
  grunt.registerTask('build', ['download-atom-shell', 'shell:app-apm-install', 'copy:app', 'generate-plist'])
