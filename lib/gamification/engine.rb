module Gamification
  class Engine < ::Rails::Engine
    isolate_namespace Gamification

    initializer 'gamification.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Gamification::ApplicationHelper
      end
    end

    initializer 'gamification.factories', after: 'factory_girl.set_factory_paths' do
      FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
