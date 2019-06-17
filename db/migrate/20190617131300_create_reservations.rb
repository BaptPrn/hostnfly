class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :listing, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
