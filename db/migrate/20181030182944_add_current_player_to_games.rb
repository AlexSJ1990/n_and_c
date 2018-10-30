class AddCurrentPlayerToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :current_player, :string
  end
end
