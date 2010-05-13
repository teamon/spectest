# Go to http://wiki.merbivore.com/pages/init-rb

# Specify your dependencies in the Gemfile but require them explicitly

use_test :rspec


# Specify your dependencies in the Gemfile

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
end

# Move this to application.rb if you want it to be reloadable in dev mode.
Merb::Router.prepare do
  match('/').to(:controller => "spectest", :action =>'index')

  default_routes
end

Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:use_mutex]           = false
  c[:session_store]       = 'cookie'
  c[:session_id_key]      = '_spectest_session_id'
  c[:session_secret_key]  = '2b790d9fd88a997da1602b437f646060b250063c'

  if Merb.env?(:production)
    # edit production settings
    c[:log_level]         = :error
    c[:log_file]          = Merb.root / "log" / "production.log"
    c[:exception_details] = false
    c[:reload_classes]    = false
    c[:reload_templates]  = false
  else
    # edit development/test settings
    c[:log_level]         = :debug
    c[:log_stream]        = STDOUT
    c[:exception_details] = true
    c[:reload_classes]    = true
    c[:reload_templates]  = true
    c[:reload_time]       = 0.5
  end
}
