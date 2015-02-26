require 'tictactoe/ui/command_line/game_setup'
require 'tictactoe/ui/command_line/user_interface'
require 'tictactoe/game'
require 'tictactoe/human_player'
require 'tictactoe/computer_player'
require 'tictactoe/stubs/stub_interface'

describe TicTacToe::UI::CommandLine::GameSetup do
  include TicTacToe::UI::CommandLine

  let(:user_interface) { TicTacToe::Stubs::StubInterface.new }
  let(:game_setup) { TicTacToe::UI::CommandLine::GameSetup.new(user_interface) }

  it 'player 1 picked as human' do
    user_interface.set_player_type(TicTacToe::UI::CommandLine::UserInterface::HUMAN_PLAYER)
    game = game_setup.setup_game
    expect(game.player_1).to be_kind_of(TicTacToe::HumanPlayer)
  end

  it 'player 1 picked as computer' do
    user_interface.set_player_type(TicTacToe::UI::CommandLine::UserInterface::COMPUTER_PLAYER)
    game = game_setup.setup_game
    expect(game.player_1).to be_kind_of(TicTacToe::ComputerPlayer)
  end

  it 'player 2 picked as human' do
    user_interface.set_player_type(TicTacToe::UI::CommandLine::UserInterface::HUMAN_PLAYER)
    game = game_setup.setup_game
    expect(game.player_2).to be_kind_of(TicTacToe::HumanPlayer)
  end

  it 'player 2 picked as computer' do
    user_interface.set_player_type(TicTacToe::UI::CommandLine::UserInterface::COMPUTER_PLAYER)
    game = game_setup.setup_game
    expect(game.player_2).to be_kind_of(TicTacToe::ComputerPlayer)
  end

  it 'raises exception when invalid player type given' do
    user_interface.set_player_type("invalid player")
    expect{game_setup.setup_game}.to raise_error(TicTacToe::UI::CommandLine::GameSetup::INVALID_PLAYER_TYPE_ERROR)
  end
end
