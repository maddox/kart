exports.template = [
  {
    label: 'View',
    submenu: [
      {
        label: 'Reload',
        accelerator: 'CommandOrControl+R',
        click: function() { BrowserWindow.getFocusedWindow().reloadIgnoringCache(); }
      },
      {
        label: 'Toggle DevTools',
        accelerator: 'CommandOrControl+Alt+I',
        click: function() { BrowserWindow.getFocusedWindow().toggleDevTools(); }
      }
    ]
  }
]
