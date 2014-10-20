exports.getTemplate = function(mainWindow) {
  return [
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
