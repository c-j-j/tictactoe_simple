module TicTacToe
  class Game

    def initialize(board, player_1, player_2)
      @board = board
      @player_1 = player_1
      @player_2 = player_2
    end

    def play_turn
      board.add_move(current_player.mark, current_player.next_move(board))
    end

    def game_over?
      board.won? || board.draw?
    end

    private

    attr_reader :board, :player_1, :player_2

    def current_player
      if board.total_moves_made.even?
        player_1
      else
        player_2
      end
    end
  end
end
