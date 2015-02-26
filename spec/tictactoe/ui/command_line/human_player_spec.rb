require 'tictactoe/ui/command_line/human_player'
require 'tictactoe/board'
require 'tictactoe/stubs/stub_interface'

describe TicTacToe::UI::CommandLine::HumanPlayer do
  let(:stub_interface) { TicTacToe::Stubs::StubInterface.new }
  let(:human_player) { TicTacToe::UI::CommandLine::HumanPlayer.new('X', stub_interface) }
  let(:board) { TicTacToe::Board.new }

  it 'gets move from user input' do
    stub_interface.prepare_user_moves(0)
    expect(human_player.next_move(board)).to eq(0)
  end

  it 'uses second user input when first is invalid against board' do
    stub_interface.prepare_user_moves(-1, 0)
    expect(human_player.next_move(board)).to eq(0)
  end

  it 'prints error message when invalid user input provided' do
    stub_interface.prepare_user_moves(-1, 0)
    human_player.next_move(board)
    expect(stub_interface.error_message_printed?).to eq(true)
  end

  it' has a mark' do
    expect(human_player.mark).to eq('X')
  end
end
