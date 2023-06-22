project('com.github.mistakenelf.pikture',
  ['c', 'vala'],
  version: '1.0.0',
  license: 'MIT'
)

gnome = import('gnome')
i18n = import('i18n')

app_id = meson.project_name()
app_title = 'Pikture'
app_name = 'pikture'
app_developer_name = 'Tyler Knipfer'
app_summary = 'A simple image viewer'
app_homepage_url = 'https://github.com/mistakenelf/pikture'
app_bug_tracker_url = 'https://github.com/mistakenelf/pikture/issues'
app_license_type = 'MIT'

version = meson.project_version()
c_compiler = meson.get_compiler('c')
vala_compiler = meson.get_compiler('vala')

add_global_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(app_id),
    language: 'c',
)

config_data = configuration_data()
config_data.set(
    'LOCALEDIR',
    join_paths(get_option('prefix'), get_option('localedir')),
)

config_data.set('APP_ID', app_id)
config_data.set('APP_PATH', '/' + app_id.replace('.', '/') + '/')
config_data.set('APP_NAME', app_name)
config_data.set('APP_TITLE', app_title)
config_data.set('APP_SUMMARY', app_summary)
config_data.set('APP_LICENSE_TYPE', app_license_type)
config_data.set('APP_DEVELOPER_NAME', app_developer_name)
config_data.set('APP_HOMEPAGE_URL', app_homepage_url)
config_data.set('APP_BUG_TRACKER_URL', app_bug_tracker_url)
config_data.set('APP_VERSION', meson.project_version())
config_data.set('GETTEXT_PACKAGE', app_id)
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data,
)

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')
add_project_arguments(['--enable-experimental'], language: 'vala')

subdir('src')
subdir('data')
subdir('po')

executable(
  app_name,
  sources,
  gresource,
  dependencies: dependencies,
  install: true
)

meson.add_install_script('meson/post_install.py')
