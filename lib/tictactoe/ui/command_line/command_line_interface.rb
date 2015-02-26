require 'tictactoe/ui/messages'

module TicTacToe
  module UI
    module CommandLine
      class CommandLineInterface

        MARK_OFFSET = 1

        def initialize(input=$stdin, output=$stdout)
          @input = input
          @output = output
        end

        def print_update(game)
          print_board(game.board)
          print_status(game)
        end

        def get_move
          input.gets.to_i - MARK_OFFSET
        end

        def print_error_message(message)
          print(message)
        end

        private

        def print_board(board)
          index = MARK_OFFSET
          board.rows.each do |row|
            row_string = ""
            row.each do |cell|
              unless cell.nil?
                row_string << format_cell(cell)
              else
                row_string << format_cell(index)
              end
              index += 1
            end
            print(row_string)
          end
        end

        def format_cell(cell)
          " #{cell} "
        end

        def print_status(game)
          game_state = game.state
          if game_state == :draw
            print(TicTacToe::UI::DRAW_MESSAGE)
          elsif game_state == :won
            print(TicTacToe::UI::WINNING_MESSAGE % game.winning_mark)
          else
            print(TicTacToe::UI::NEXT_PLAYER_TO_GO % game.current_player_mark)
          end
        end

        def print(message)
          output.puts message
        end

        attr_reader :game, :input, :output
      end
    end
  end
end
