# frozen_string_literal: true

module SolidusStarterFrontend
  class AuthenticationRspecGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../src/with_authentication', __dir__)

    def install
      copy_file 'spec/controllers/controller_helpers_spec.rb'
      copy_file 'spec/controllers/spree/base_controller_spec.rb'
      copy_file 'spec/controllers/spree/checkout_controller_spec.rb'
      copy_file 'spec/controllers/spree/products_controller_spec.rb'
      copy_file 'spec/controllers/spree/user_passwords_controller_spec.rb'
      copy_file 'spec/controllers/spree/user_registrations_controller_spec.rb'
      copy_file 'spec/controllers/spree/user_sessions_controller_spec.rb'
      copy_file 'spec/controllers/spree/users_controller_spec.rb'
      copy_file 'spec/mailers/user_mailer_spec.rb'
      copy_file 'spec/requests/spree/orders_ability_spec.rb'
      copy_file 'spec/solidus_starter_frontend_helper.rb'
      copy_file 'spec/support/solidus_starter_frontend/features/fill_addresses_fields.rb'
      copy_file 'spec/support/solidus_starter_frontend/system_helpers.rb'
      copy_file 'spec/system/authentication'
      copy_file 'spec/system/checkout_spec.rb'
    end
  end
end
