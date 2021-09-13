# frozen_string_literal: true

require_relative 'enable_code'
require_relative 'disable_code'
require_relative 'remove_markers'

module SolidusStarterFrontend
  class RspecGenerator < Rails::Generators::Base
    PATHS_WITH_AUTHENTICATION_CODE = []
    PATHS_WITH_NON_AUTHENTICATION_CODE = []
    AUTHENTICATION_PATHS = []

    source_root File.expand_path('../../../src/base', __dir__)

    class_option 'skip-authentication', type: :boolean, default: false

    def install
      gem_group :development, :test do
        gem 'apparition', '~> 0.6.0'
        gem 'rails-controller-testing', '~> 1.0.5'
        gem 'rspec-activemodel-mocks', '~> 1.1.0'
        gem 'solidus_dev_support', '~> 2.5'
      end

      Bundler.with_original_env do
        run 'bundle install'
      end

      # Copy spec files
      directory 'spec/controllers', exclude_pattern: exclude_authentication_paths_pattern
      directory 'spec/helpers'
      directory 'spec/mailers', exclude_pattern: exclude_authentication_paths_pattern
      directory 'spec/requests'
      directory 'spec/support/solidus_starter_frontend', exclude_pattern: exclude_authentication_paths_pattern
      directory 'spec/system', exclude_pattern: exclude_authentication_paths_pattern
      directory 'spec/views'
      copy_file 'spec/solidus_starter_frontend_helper.rb'

      if include_authentication?
        PATHS_WITH_AUTHENTICATION_CODE.each do |path|
          SolidusStarterFrontend::EnableCode.new(
            generator: self,
            namespace: 'RspecGenerator/with-authentication',
            path: path
          ).call

          SolidusStarterFrontend::RemoveMarkers.new(
            generator: self,
            namespace: 'RspecGenerator/with-authentication',
            path: path
          ).call
        end

        PATHS_WITH_NON_AUTHENTICATION_CODE.each do |path|
          SolidusStarterFrontend::DisableCode.new(
            generator: self,
            namespace: 'RspecGenerator/without-authentication',
            path: path
          ).call
        end
      else
        PATHS_WITH_NON_AUTHENTICATION_CODE.each do |path|
          SolidusStarterFrontend::EnableCode.new(
            generator: self,
            namespace: 'RspecGenerator/without-authentication',
            path: path
          ).call

          SolidusStarterFrontend::RemoveMarkers.new(
            generator: self,
            namespace: 'RspecGenerator/without-authentication',
            path: path
          ).call
        end

        PATHS_WITH_AUTHENTICATION_CODE.each do |path|
          SolidusStarterFrontend::DisableCode.new(
            generator: self,
            namespace: 'RspecGenerator/with-authentication',
            path: path
          ).call
        end
      end
    end

    private

    def include_authentication?
      !options['skip-authentication']
    end

    def exclude_authentication_paths_pattern
      @exclude_authentication_paths_pattern ||=
        options['skip-authentication'] ? Regexp.new(AUTHENTICATION_PATHS.join('|')) : nil
    end
  end
end
