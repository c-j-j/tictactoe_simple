module TicTacToe
  module Stubs
    class StubInterface
      def prepare_user_moves(*moves)
        @moves = moves
      end

      def get_move
        @moves.shift
      end

      def error_message_printed?
        @error_message_printed
      end

      def print_error_message(message)
        @error_message_printed = true
      end
    end
  end
end
