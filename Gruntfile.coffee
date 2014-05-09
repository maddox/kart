fs = require 'fs'
path = require 'path'

packageJson = require './package.json'

module.exports = (grunt) ->
  appName = "#{packageJson.name}.app"
  [major, minor, patch] = packageJson.version.split('.')

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    symlink:
      app:
        link: path.join('atom-shell', 'Atom.app', 'Contents', 'Resources', 'app')
        target: path.join('..', '..', '..', '..', 'app')
        options:
          type: 'dir'
          force: true
          overwrite: true

    'download-atom-shell':
      version: packageJson.atomShellVersion
      outputDir: path.join('atom-shell')
      downloadDir: '/tmp/downloaded-atom-shell'
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
          expand: true,
          src: ['app/**', 'speakeasy.pem']
          dest: 'atom-shell/Atom.app/Contents/Resources/'
        ]

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-symbolic-link')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-download-atom-shell')
  grunt.loadTasks('tasks')

  grunt.registerTask('bootstrap', ['download-atom-shell', 'symlink:app', 'generate-plist', 'shell:app-apm-install'])
  grunt.registerTask('build', ['download-atom-shell', 'shell:app-apm-install', 'copy:app', 'generate-plist'])
