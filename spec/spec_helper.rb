require 'tictactoe/ui/command_line/user_interface'
require 'tictactoe/game'
require 'tictactoe/roles/player_role_tests'
require 'tictactoe/roles/user_interface_role_tests'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
