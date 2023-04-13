sources = files(
  'Application.vala',
  'MainWindow.vala',
)

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

executable(
  'Pikture',
  sources,
  dependencies: dependencies,
  install: true
)
