require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/computer_player'
require 'tictactoe/ui/command_line/command_line_interface'

describe "Integration Tests" do

  let(:board) { TicTacToe::Board.new }
  let(:player_1) { TicTacToe::ComputerPlayer.new('X', 'O') }
  let(:player_2) { TicTacToe::ComputerPlayer.new('O', 'X') }
  let(:user_interface) { TicTacToe::UI::CommandLine::CommandLineInterface.new }

  it 'runs through cvc game and ends in draw with 3x3 board' do
    cvc_game = TicTacToe::Game.new(user_interface, board, player_1, player_2 )
    cvc_game.play
    expect(cvc_game.state).to be(:draw)
  end
end
