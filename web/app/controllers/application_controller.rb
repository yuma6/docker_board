class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
  
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  
    # Don't generate system test files.
    config.generators.system_tests = nil
  
    # クロスオリジンで POST や PUT を拒否しない
    config.action_controller.forgery_protection_origin_check = false
end