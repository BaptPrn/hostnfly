class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.integer :num_rooms, null: false
      t.timestamps
    end
  end
end
