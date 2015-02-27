require 'spec_helper'
require 'tictactoe/computer_player'
require 'tictactoe/board'
require 'tictactoe/helpers/board_helper.rb'
require 'tictactoe/stubs/stub_player.rb'

describe TicTacToe::ComputerPlayer do
  include PlayerRoleTests

  let(:mark){'X'}
  let(:opponent_mark){'O'}

  let(:board) {TicTacToe::Board.new }
  let(:board_helper) {TicTacToe::TestHelpers::BoardHelper.new }
  let(:opponent) {TicTacToe::Stubs::StubPlayer.new(opponent_mark)}
  let(:computer_player) { TicTacToe::ComputerPlayer.new(mark, opponent_mark) }

  it 'responds to player methods' do
    responds_to_player_methods?(computer_player)
  end

  it 'has a mark' do
    expect(computer_player.mark).to be(mark)
  end

  it 'score is 0 when game is initially a tie' do
    board_helper.populate_board_with_tie(board, computer_player.mark, opponent.mark)
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TicTacToe::ComputerPlayer::DRAW_SCORE)
  end

  it 'score is positive when this player initially wins' do
    board_helper.populate_board_with_win(board, computer_player.mark)
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TicTacToe::ComputerPlayer::WIN_SCORE)
  end

  it 'score is negative when this player initially loses' do
    board_helper.populate_board_with_win(board, opponent_mark)
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TicTacToe::ComputerPlayer::LOSE_SCORE)
  end

  it 'wins by taking the first row' do
    board_helper.add_moves_to_board(board, [0, 1], computer_player.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(2)
  end

  it 'wins by going in the centre' do
    board_helper.add_moves_to_board(board, [0, 8], computer_player.mark)
    board_helper.add_moves_to_board(board, [2, 6], opponent.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(4)
  end

  it 'forks to give multiple chances to win when computer occupies centre' do
    board_helper.add_moves_to_board(board, [0, 4], computer_player.mark)
    board_helper.add_moves_to_board(board, [1, 8], opponent.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(3)
  end

  it 'blocks opponent from winning' do
    board_helper.add_moves_to_board(board, [0, 3], opponent.mark)
    board_helper.add_moves_to_board(board, [4], computer_player.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(6)
  end

  it 'creates fork when opponent goes opposite corner' do
    board_helper.add_moves_to_board(board, [0, 2], computer_player.mark)
    board_helper.add_moves_to_board(board, [1, 8], opponent.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(6)
  end

  it 'goes in any corner when 3x3 board is empty' do
    computer_move = computer_player.next_move(board)
    expect(computer_move).to satisfy {|move| [0,2,6,8].include?(move)}
  end

  it 'goes centre when opponent is in top left' do
    board_helper.add_moves_to_board(board, [0], opponent.mark)
    move = computer_player.next_move(board)
    expect(move).to eq(4)
  end

  it 'throws exception when game is already over' do
    board_helper.populate_board_with_tie(board, computer_player, opponent)
    expect {computer_player.next_move(board)}.to raise_error(TicTacToe::ComputerPlayer::INDETERMINATE_MOVE_ERROR)
  end
end
