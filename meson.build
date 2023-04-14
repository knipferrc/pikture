project('com.github.mistakenelf.pikture',
  ['c', 'vala'],
  version: '1.9.2'
)

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

gnome = import('gnome')
i18n = import('i18n')

app_id = meson.project_name()
version = meson.project_version()
c_compiler = meson.get_compiler('c')
vala_compiler = meson.get_compiler('vala')

conf = configuration_data()
conf.set('app_id', app_id)
conf.set('version', version)
conf.set('bindir', get_option('prefix') / get_option('bindir'))

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

