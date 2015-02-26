require 'tictactoe/board'
require 'tictactoe/helpers/board_helper'

describe TicTacToe::Board do
  let(:board_helper) { TicTacToe::TestHelpers::BoardHelper.new }
  let(:board) { TicTacToe::Board.new }

  it 'adds move to board' do
    board.add_move('X', 0)
    expect(board.get_mark_at_position(0)).to eq('X')
  end

  it 'not won when board is empty' do
    expect(board.won?).to eq(false)
  end

  it 'won when winning row occupied' do
    board_helper.add_moves_to_board(board, [0, 1, 2], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when middle row occupied' do
    board_helper.add_moves_to_board(board, [3, 4, 5], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when bottom row occupied' do
    board_helper.add_moves_to_board(board, [6, 7, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when left column occupied' do
    board_helper.add_moves_to_board(board, [0, 3, 6], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when middle column occupied' do
    board_helper.add_moves_to_board(board, [1, 4, 7], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when right column occupied' do
    board_helper.add_moves_to_board(board, [2, 5, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when bottom left to top right diagonal occupied' do
    board_helper.add_moves_to_board(board, [6, 4, 2], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when top left to bottom right diagonal occupied' do
    board_helper.add_moves_to_board(board, [0, 4, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'not drawn when board is empty' do
    expect(board.draw?).to eq(false)
  end

  it 'not drawn when board has been won' do
    board_helper.add_moves_to_board(board, [0, 4, 8], 'X')
    expect(board.draw?).to eq(false)
  end

  it 'drawn when full board with no winner' do
    board_helper.add_moves_to_board(board, [0, 1, 5, 6, 8], 'X')
    board_helper.add_moves_to_board(board, [2, 3, 4, 7], 'O')
    expect(board.draw?).to eq(true)
  end

  it 'empty board has 0 total moves made' do
    expect(board.total_moves_made).to eq(0)
  end

  it 'board has 2 total moves made' do
    board_helper.add_moves_to_board(board, [0, 1], 'X')
    expect(board.total_moves_made).to eq(2)
  end

  it 'move is valid when in range' do
    expect(board.move_valid?(0)).to eq(true)
    expect(board.move_valid?(TicTacToe::Board::BOARD_SIZE - 1)).to eq(true)
  end

  it 'move is invalid when move is below zero' do
    expect(board.move_valid?(-1)).to eq(false)
  end

  it 'move is invalid when move exceeds board size' do
    expect(board.move_valid?(TicTacToe::Board::BOARD_SIZE)).to eq(false)
  end

  it 'move is invalid when move is occupied' do
    board.add_move('X', 1)
    expect(board.move_valid?(1)).to eq(false)
  end

  it 'empty board has 9 empty positions' do
    expect(board.empty_positions.size).to eq(9)
  end

  it 'board has one empty position' do
    board_helper.add_moves_to_board(board, (0...7).to_a, 'X')
    expect(board.empty_positions).to include(8)
  end

  it 'copies board' do
    board.add_move('X', 1)
    new_board = board.copy
    expect(new_board.get_mark_at_position(1)).to eq('X')
  end

  it 'no winner when board is empty' do
    expect(board.winner).to eq(nil)
  end

  it 'winner exists when board has been won' do
    board_helper.add_moves_to_board(board, [0, 4, 8], 'X')
    expect(board.winner).to eq('X')
  end
end
