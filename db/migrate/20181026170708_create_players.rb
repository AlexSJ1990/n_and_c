# db/migrate/**********_create_players.rb
class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string    :username
      t.string    :password
      t.timestamps # add 2 columns, `created_at` and `updated_at`
    end
  end
end
