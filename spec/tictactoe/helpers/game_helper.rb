require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/stubs/stub_player'
require 'tictactoe/helpers/board_helper'

module TicTacToe
  module TestHelpers
    class GameHelper

      def self.new_game
        TicTacToe::Game.new(nil, new_board, new_player('X'), new_player('O'))
      end

      def self.drawn_game
        player_1 = new_player('X')
        player_2 = new_player('O')
        board = new_board
        board_helper.populate_board_with_tie(board, player_1.mark, player_2.mark)
        TicTacToe::Game.new(nil, board, player_1, player_2)
      end

      def self.won_game
        player_1 = new_player('X')
        board = new_board
        board_helper.populate_board_with_win(board, player_1.mark)
        TicTacToe::Game.new(nil, board, player_1, new_player('O'))
      end

      def self.board_helper
        TicTacToe::TestHelpers::BoardHelper.new
      end

      def self.new_board
        TicTacToe::Board.new
      end

      def self.new_player(mark)
        TicTacToe::Stubs::StubPlayer.new(mark)
      end
    end
  end
end
