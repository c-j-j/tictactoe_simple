require 'spec_helper'
require 'tictactoe/ui/command_line/user_interface'
require 'tictactoe/helpers/game_helper'
require 'tictactoe/ui/messages'

describe TicTacToe::UI::CommandLine::UserInterface do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:interface) { TicTacToe::UI::CommandLine::UserInterface.new(input, output)}

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

  it 'user can select human player' do
    input.string = "1"
    expect(interface.get_player_type('X')).to eq(TicTacToe::UI::CommandLine::UserInterface::PLAYER_TYPES[1])
  end

  it 'user can select computer player' do
    input.string = "2"
    expect(interface.get_player_type('X')).to eq(TicTacToe::UI::CommandLine::UserInterface::PLAYER_TYPES[2])
  end

  it 'asks for input twice when user gives invalid input' do
    input.string = "a\n1"
    expect(interface.get_player_type('X')).to eq(TicTacToe::UI::CommandLine::UserInterface::PLAYER_TYPES[1])
  end

  it 'displays message to ask for player type' do
    input.string = "1"
    interface.get_player_type('X')
    expect(output.string).to include(TicTacToe::UI::SELECT_PLAYER_TYPE % 'X')
    TicTacToe::UI::CommandLine::UserInterface::PLAYER_TYPES.each do |option, player_type|
      expect(output.string).to include(option.to_s)
      expect(output.string).to include(player_type)
    end
  end
end
