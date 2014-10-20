exports.getTemplate = function(mainWindow) {
  return [
    {
      label: 'File',
      submenu: [
        {
          label: 'Quit',
          accelerator: 'CommandOrControl+Q',
          click: function() { mainWindow.close(); }
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
