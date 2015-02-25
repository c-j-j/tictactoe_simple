module TicTacToe
  module Stubs
    class StubPlayer

      attr_reader :mark

      def initialize(mark)
        @mark = mark
      end

      def prepare_next_move(next_move)
        @next_move = next_move
      end

      def next_move(board)
        return @next_move
      end
    end
  end
end
