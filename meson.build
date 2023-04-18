project('pikture',
  ['c', 'vala'],
  version: '0.0.1',
  license: 'MIT'
)

gnome = import('gnome')
i18n = import('i18n')

app_id = meson.project_name()
version = meson.project_version()
c_compiler = meson.get_compiler('c')
vala_compiler = meson.get_compiler('vala')

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

add_project_arguments('-DGETTEXT_PACKAGE="' + app_id + '"', language: 'c')
add_project_arguments(['--enable-experimental'], language: 'vala')

subdir('src')
subdir('data')
subdir('po')

executable(
  'pikture',
  sources,
  dependencies: dependencies,
  install: true
)

