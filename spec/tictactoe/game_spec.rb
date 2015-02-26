require 'spec_helper'
require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/stubs/stub_player'
require 'tictactoe/helpers/board_helper'

describe TicTacToe::Game do
  let(:user_interface) { instance_double("TicTacToe::UI::CommandLine::UserInterface", :print_update => nil) }
  let(:board_helper) { TicTacToe::TestHelpers::BoardHelper.new }
  let(:player_1) { TicTacToe::Stubs::StubPlayer.new('X') }
  let(:player_2) { TicTacToe::Stubs::StubPlayer.new('O') }
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(user_interface, board, player_1, player_2) }

  it 'does not add move when game is over' do
    board_helper.add_moves_to_board(board, [0, 1, 2], player_1.mark)
    player_2.prepare_next_move(4)
    game.play
    expect(board.get_mark_at_position(4)).to eq(nil)
  end

  it 'adds moves to board until game is over' do
    player_1.prepare_next_move(0, 1, 2)
    player_2.prepare_next_move(3, 4)
    game.play
    expect_board_to_contain_marks([0, 1, 2], player_1.mark)
    expect_board_to_contain_marks([3, 4], player_2.mark)
  end

  it 'game not over when board is empty' do
    expect(game.game_over?).to eq(false)
  end

  it 'game over due to win' do
    board_helper.populate_board_with_win(board, player_1.mark)
    expect(game.game_over?).to eq(true)
  end

  it 'game over due to draw' do
    board_helper.populate_board_with_tie(board, player_1.mark, player_2.mark)
    expect(game.game_over?).to eq(true)
  end

  it 'sends update to interface before game started' do
    board_helper.populate_board_with_win(board, player_1.mark)
    expect(user_interface)
      .to receive(:print_update)
      .with(game)
    game.play
  end

  it 'sends update to interface before and during game' do
    board_helper.add_moves_to_board(board, [0, 1], player_1.mark)
    player_1.prepare_next_move(2)
    expect(user_interface)
      .to receive(:print_update)
      .at_least(:twice)
      .with(game)
    game.play
  end

  it 'state is in progress when game not over' do
    expect(game.state).to eq(:in_progress)
  end

  it 'state shows that game has won' do
    board_helper.populate_board_with_win(board, player_1.mark)
    expect(game.state).to eq(:won)
  end

  it 'state shows game has drawn' do
    board_helper.populate_board_with_tie(board, player_1.mark, player_2.mark)
    expect(game.state).to eq(:draw)
  end

  it 'has winner' do
    board_helper.populate_board_with_win(board, player_1.mark)
    expect(game.winning_mark).to eq(player_1.mark)
  end

  it 'has current player mark' do
    expect(game.current_player_mark).to eq(player_1.mark)
  end

  def expect_board_to_contain_marks(positions, mark)
    positions.each do |position|
      expect(board.get_mark_at_position(position)).to eq(mark)
    end
  end

end
