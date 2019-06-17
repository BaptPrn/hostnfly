class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.references :listing, index: true, foreign_key: true
      t.integer :mission_type, index: true, null: false
      t.date :date, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
