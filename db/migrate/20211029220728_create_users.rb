class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.integer :posts_counter
      t.string :photo

      t.timestamps
    end
  end
end
