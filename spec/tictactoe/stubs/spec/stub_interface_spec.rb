require 'spec_helper'
require 'tictactoe/stubs/stub_interface'

describe TicTacToe::Stubs::StubInterface do
  include UserInterfaceRoleTests

  let(:stub_interface) {TicTacToe::Stubs::StubInterface.new}

  it 'responds to interface methods' do
    responds_to_user_interface_methods?(stub_interface)
  end

end
