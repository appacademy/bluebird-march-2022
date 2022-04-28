class DropChirps < ActiveRecord::Migration[5.2]
  def change
    drop_table :chirps
  end
end
