require 'spec_helper'
require 'tictactoe/stubs/stub_player'

describe TicTacToe::Stubs::StubPlayer do
  include PlayerRoleTests

  let(:stub_player) {TicTacToe::Stubs::StubPlayer.new('X')}

  it 'responds to player methods' do
    responds_to_player_methods?(stub_player)
  end
end
