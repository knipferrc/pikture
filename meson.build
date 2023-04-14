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

add_project_arguments('-DGETTEXT_PACKAGE="' + app_id + '"', language: 'c')
add_project_arguments(['--enable-experimental'], language: 'vala')

i18n.merge_file(
    input: 'data' / 'pikture.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: meson.source_root() / 'po',
    type: 'desktop',
    install: true,
    install_dir: get_option('datadir') / 'applications'
)

i18n.merge_file(
    input: 'data' / 'pikture.metainfo.xml.in',
    output: meson.project_name() + '.metainfo.xml',
    po_dir: meson.source_root() / 'po',
    install: true,
    install_dir: get_option('datadir') / 'metainfo'
)

subdir('src')
subdir('data')
subdir('po')

executable(
  'pikture',
  sources,
  dependencies: dependencies,
  install: true
)

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
)

