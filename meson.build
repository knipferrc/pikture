project('com.github.mistakenelf.pikture',
  ['c', 'vala'],
  version: '1.9.2'
)

gnome = import('gnome')
i18n = import('i18n')

app_id = meson.project_name()
version = meson.project_version()

c_compiler = meson.get_compiler('c')
vala_compiler = meson.get_compiler('vala')

add_project_arguments('-DGETTEXT_PACKAGE="' + app_id + '"', language: 'c')
add_project_arguments(['--enable-experimental'], language: 'vala')

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

subdir('src')
subdir('data')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
)

