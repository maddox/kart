fs = require 'fs'
path = require 'path'

rootPath = path.join(__dirname, '..')
packagePath = path.join(rootPath, 'package.json')
shellPath = path.join(rootPath, 'atom-shell')
origAppPath = path.join(shellPath, 'Atom.app')
infoPlistPath = path.join(origAppPath, 'Contents', 'Info.plist')
iconPath = path.join(origAppPath, 'Contents', 'Resources', 'atom.icns')

module.exports = (grunt) ->
  {cp, rm} = require('./task-helpers')(grunt)

  grunt.registerTask 'generate-plist', 'Generates the Info.plist from the package.json', ->
    if !fs.existsSync(packagePath)
      grunt.log.error('No package.json found')
      return false

    packageContents = fs.readFileSync(packagePath)
    config = JSON.parse(packageContents)
    config = config.application || {}

    name = config.name || 'Kart'
    appPath = path.join(shellPath, "#{name}.app")
    icon = config.icon
    version = process.env.APP_VERSION
    version += ".#{process.env.GIT_VERSION}" if process.env.GIT_VERSION

    plist = """<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleIdentifier</key>
      <string>org.kart.desktop</string>
      <key>CFBundleExecutable</key>
      <string>Atom</string>
      <key>CFBundleName</key>
      <string>#{name}</string>
      <key>CFBundleDisplayName</key>
      <string>#{name}</string>
      <key>CFBundlePackageType</key>
      <string>APPL</string>
      <key>CFBundleIconFile</key>
      <string>Atom.icns</string>
      <key>CFBundleVersion</key>
      <string>#{version}</string>
      <key>NSMainNibFile</key>
      <string>MainMenu</string>
      <key>NSPrincipalClass</key>
      <string>AtomApplication</string>
      <key>NSSupportsAutomaticGraphicsSwitching</key>
      <true/>
      <key>CFBundleDocumentTypes</key>
      <array>
        <dict>
    			<key>CFBundleTypeRole</key>
    			<string>Editor</string>
    			<key>LSItemContentTypes</key>
    			<array>
            <string>public.directory</string>
    				<string>com.apple.bundle</string>
    				<string>com.apple.resolvable</string>
    			</array>
    		</dict>
      </array>
    </dict>
    </plist>"""

    fs.writeFileSync(infoPlistPath, plist)
    grunt.log.writeln("Generated and saved #{infoPlistPath.cyan}")

    if icon
      newIconPath = path.resolve(rootPath, icon)
      cp(newIconPath, iconPath)

    if name != 'Kart'
      rm(appPath)
      fs.renameSync(origAppPath, appPath)
      grunt.log.writeln("Moved the app to #{appPath.cyan}")
