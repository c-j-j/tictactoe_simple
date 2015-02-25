require 'tictactoe/board'

describe TicTacToe::Board do
  let(:board) { TicTacToe::Board.new }

  it 'adds move to board' do
    board.add_move('X', 0)
    expect(board.get_mark_at_position(0)).to eq('X')
  end

  it 'not won when board is empty' do
    expect(board.won?).to eq(false)
  end

  it 'won when winning row occupied' do
    add_moves_to_board(board, [0, 1, 2], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when middle row occupied' do
    add_moves_to_board(board, [3, 4, 5], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when bottom row occupied' do
    add_moves_to_board(board, [6, 7, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when left column occupied' do
    add_moves_to_board(board, [0, 3, 6], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when middle column occupied' do
    add_moves_to_board(board, [1, 4, 7], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when right column occupied' do
    add_moves_to_board(board, [2, 5, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when bottom left to top right diagonal occupied' do
    add_moves_to_board(board, [6, 4, 2], 'X')
    expect(board.won?).to eq(true)
  end

  it 'won when top left to bottom right diagonal occupied' do
    add_moves_to_board(board, [0, 4, 8], 'X')
    expect(board.won?).to eq(true)
  end

  it 'not drawn when board is empty' do
    expect(board.draw?).to eq(false)
  end

  it 'not drawn when board has been won' do
    add_moves_to_board(board, [0, 4, 8], 'X')
    expect(board.draw?).to eq(false)
  end

  it 'drawn when full board with no winner' do
    add_moves_to_board(board, [0, 1, 5, 6, 8], 'X')
    add_moves_to_board(board, [2, 3, 4, 7], 'O')
    expect(board.draw?).to eq(true)
  end

  it 'empty board has 0 total moves made' do
    expect(board.total_moves_made).to eq(0)
  end

  it 'board has 2 total moves made' do
    add_moves_to_board(board, [0, 1], 'X')
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

  def add_moves_to_board(board, moves, mark)
    moves.each do |move|
      board.add_move(mark, move)
    end
  end

end
