require 'tictactoe/game'
require 'tictactoe/human_player'
require 'tictactoe/computer_player'
require 'tictactoe/ui/command_line/user_interface'
require 'tictactoe/board'

module TicTacToe
  module UI
    module CommandLine
      class GameSetup

        INVALID_PLAYER_TYPE_ERROR = "Invalid Player Type given"

        def initialize(user_interface = TicTacToe::UI::CommandLine::UserInterface.new)
          @user_interface = user_interface
        end

        def setup_game
          board = TicTacToe::Board.new
          player_1 = create_player_from_type(user_interface.get_player_type('X'), 'X', 'O')
          player_2 = create_player_from_type(user_interface.get_player_type('O'), 'O', 'X')
          TicTacToe::Game.new(user_interface, board, player_1, player_2)
        end

        private

        def create_player_from_type(player_type, mark, opponent_mark)
          if player_type == UserInterface::HUMAN_PLAYER
            return TicTacToe::HumanPlayer.new(mark)
          elsif player_type == UserInterface::COMPUTER_PLAYER
            return TicTacToe::ComputerPlayer.new(mark, opponent_mark)
          else
            raise INVALID_PLAYER_TYPE_ERROR
          end
        end

        attr_reader :user_interface
      end
    end
  end
end
