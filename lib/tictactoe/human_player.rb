module TicTacToe
  class HumanPlayer

    INVALID_MOVE_ERROR = "Error: Invalid Move"

    attr_reader :mark

    def initialize(mark, user_interface = TicTacToe::UI::CommandLine::UserInterface.new)
      @mark = mark
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
