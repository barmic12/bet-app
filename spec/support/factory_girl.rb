# RSpec
# spec/support/factory_girl.rb
require 'factory_bot_rails'
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end