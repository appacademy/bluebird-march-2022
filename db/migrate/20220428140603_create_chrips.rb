class CreateChrips < ActiveRecord::Migration[5.2]
  def change
    create_table :chirps do |t|
      t.string :body, :limit => 140, null: false
      t.integer :author_id, null: false
      t.timestamps
    end

    add_index :chirps, :author_id
  end
end
