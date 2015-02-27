module UserInterfaceRoleTests

  def responds_to_user_interface_methods?(user_interface)
    expect(user_interface).to respond_to(:get_player_type)
    expect(user_interface).to respond_to(:get_move)
    expect(user_interface).to respond_to(:print_error_message)
  end

end
