module TicTacToe
  module UI
    module CommandLine
      class HumanPlayer

        INVALID_MOVE_ERROR = "Error: Invalid Move"

        def initialize(user_interface)
          @user_interface = user_interface
        end

        def next_move(board)
          while true
            user_input = user_interface.get_move
            return user_input if board.move_valid?(user_input)
            user_interface.print_error_message(INVALID_MOVE_ERROR)
          end
        end

        private

        attr_reader :user_interface
      end
    end
  end
end
