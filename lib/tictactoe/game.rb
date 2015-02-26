module TicTacToe
  class Game

    attr_reader :board

    def initialize(user_interface, board, player_1, player_2)
      @user_interface = user_interface
      @board = board
      @player_1 = player_1
      @player_2 = player_2
    end

    def play
      user_interface.print_update(self)
      until game_over?
        board.add_move(current_player.mark, current_player.next_move(board))
        user_interface.print_update(self)
      end
    end

    def game_over?
      won? || draw?
    end

    def state
      return :won if won?
      return :draw if draw?
      :in_progress
    end

    def winning_mark
      board.winner
    end

    def current_player_mark
      current_player.mark
    end

    private

    def won?
      board.won?
    end

    def draw?
      board.draw?
    end

    def current_player
      if board.total_moves_made.even?
        player_1
      else
        player_2
      end
    end

    attr_reader :player_1, :player_2, :user_interface

  end
end
