
class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string    :starter_player
      t.string    :result
      t.boolean   :game_over, default: false
      t.string    :player
      t.timestamps # add 2 columns, `created_at` and `updated_at`
    end
  end
end
