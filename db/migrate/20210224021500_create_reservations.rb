class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime :starttime
      t.datetime :finishtime
      t.references :item, foreign_key: true 
      t.references :member, foreign_key: true 
      
      t.timestamps
    end
  end
end
