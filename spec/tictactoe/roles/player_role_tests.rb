module PlayerRoleTests

  def responds_to_player_methods?(player)
    expect(player).to respond_to(:next_move)
  end

end
