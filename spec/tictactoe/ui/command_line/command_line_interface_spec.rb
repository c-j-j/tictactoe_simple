require 'spec_helper'
require 'tictactoe/ui/command_line/command_line_interface'
require 'tictactoe/helpers/game_helper'
require 'tictactoe/ui/messages'

describe TicTacToe::UI::CommandLine::CommandLineInterface do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:interface) { TicTacToe::UI::CommandLine::CommandLineInterface.new(input, output)}

  it 'update displays next player to go when game in progress' do
    game = TicTacToe::TestHelpers::GameHelper.new_game
    interface.print_update(game)
    expect(output.string).to include(TicTacToe::UI::NEXT_PLAYER_TO_GO % game.current_player_mark)
  end

  it 'update displays draw message' do
    game = TicTacToe::TestHelpers::GameHelper.drawn_game
    interface.print_update(game)
    expect(output.string).to include(TicTacToe::UI::DRAW_MESSAGE)
  end

  it 'update displays winner' do
    game = TicTacToe::TestHelpers::GameHelper.won_game
    interface.print_update(game)
    expect(output.string).to include(TicTacToe::UI::WINNING_MESSAGE % game.winning_mark)
  end

  it 'displays empty board' do
    game = TicTacToe::TestHelpers::GameHelper.new_game
    interface.print_update(game)
    rows = output.string.lines

    expect(rows[0]).to include("1  2  3")
    expect(rows[1]).to include("4  5  6")
    expect(rows[2]).to include("7  8  9")
  end

  it 'prints marks on board' do
    game = TicTacToe::TestHelpers::GameHelper.drawn_game
    interface.print_update(game)
    expect(output.string).to include("X")
    expect(output.string).to include("O")
  end

  it 'gets move from input and decrements by offset' do
    input.string = "1"
    expect(interface.get_move).to eq(0)
  end

  it 'prints out error message' do
    interface.print_error_message("error")
    expect(output.string).to include("error")
  end
end
