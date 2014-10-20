exports.getTemplate = function(app, mainWindow) {
  return [
    {
      label: 'File',
      submenu: [
        {
          label: 'Quit',
          accelerator: 'CommandOrControl+Q',
          click: function() { app.quit(); }
        }
      ]
    },
    {
      label: 'View',
      submenu: [
        {
          label: 'Reload',
          accelerator: 'CommandOrControl+R',
          click: function() { mainWindow.reloadIgnoringCache(); }
        },
        {
          label: 'Toggle DevTools',
          accelerator: 'CommandOrControl+Alt+I',
          click: function() { mainWindow.toggleDevTools(); }
        }
      ]
    }
  ]
}
