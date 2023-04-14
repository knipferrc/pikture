conf = configuration_data()
conf.set('app_id', app_id)
conf.set('version', version)
conf.set('bindir', get_option('prefix') / get_option('bindir'))

desktop_conf = configure_file(
  input: 'pikture.desktop.in',
  output: '@0@.desktop.in'.format(app_id),
  configuration: conf
)
