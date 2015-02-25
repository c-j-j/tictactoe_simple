require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/stubs/stub_player'
require 'tictactoe/helpers/board_helper'

describe TicTacToe::Game do
  let(:board_helper) { TicTacToe::TestHelpers::BoardHelper.new }
  let(:player_1) { TicTacToe::Stubs::StubPlayer.new('X') }
  let(:player_2) { TicTacToe::Stubs::StubPlayer.new('O') }
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(board, player_1, player_2) }

  it 'adds player 1 move onto board when board is empty' do
    player_1.prepare_next_move(3)
    game.play_turn
    expect(board.get_mark_at_position(3)).to eq(player_1.mark)
  end

  it 'adds player 2 to board when board has an odd number of total moves' do
    board.add_move('X', 0)
    player_2.prepare_next_move(2)
    game.play_turn
    expect(board.get_mark_at_position(2)).to eq(player_2.mark)
  end

  it 'game not over when board is empty' do
    expect(game.game_over?).to eq(false)
  end

  it 'game over due to won' do
    board_helper.populate_board_with_win(board, player_1.mark)
    expect(game.game_over?).to eq(true)
  end

  it 'game over due to draw' do
    board_helper.populate_board_with_tie(board, player_1.mark, player_2.mark)
    expect(game.game_over?).to eq(true)
  end
end
