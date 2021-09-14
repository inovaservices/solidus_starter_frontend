# frozen_string_literal: true

module SolidusStarterFrontend
  class AuthenticationGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../src/with_authentication', __dir__)

    class_option 'skip-specs', type: :boolean, default: false

    def install
      copy_file 'app/controllers/spree/checkout_controller.rb'
      copy_file 'app/controllers/spree/user_confirmations_controller.rb'
      copy_file 'app/controllers/spree/user_passwords_controller.rb'
      copy_file 'app/controllers/spree/user_registrations_controller.rb'
      copy_file 'app/controllers/spree/user_sessions_controller.rb'
      copy_file 'app/controllers/spree/users_controller.rb'
      copy_file 'app/mailers/spree/user_mailer.rb'
      copy_file 'app/views/spree/checkout/registration.html.erb'
      copy_file 'app/views/spree/components/layout/_top_bar.html.erb'
      copy_file 'app/views/spree/components/navigation/_auth_link.html.erb'
      directory 'app/views/spree/user_mailer'
      directory 'app/views/spree/user_passwords'
      directory 'app/views/spree/user_registrations'
      directory 'app/views/spree/user_sessions'
      directory 'app/views/spree/users'
      copy_file 'config/initializers/solidus_auth_devise_unauthorized_redirect.rb'
      copy_file 'config/routes.rb'

      invoke 'solidus_starter_frontend:authentication_rspec', [], force: true if include_specs?
    end

    private

    def include_specs?
      !options['skip-specs']
    end
  end
end
