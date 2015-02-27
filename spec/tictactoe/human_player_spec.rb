require 'spec_helper'
require 'tictactoe/human_player'
require 'tictactoe/board'
require 'tictactoe/stubs/stub_interface'

describe TicTacToe::HumanPlayer do
  include PlayerRoleTests

  let(:stub_interface) { TicTacToe::Stubs::StubInterface.new }
  let(:human_player) { TicTacToe::HumanPlayer.new('X', stub_interface) }
  let(:board) { TicTacToe::Board.new }

  it 'responds to player methods' do
    responds_to_player_methods?(human_player)
  end

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
