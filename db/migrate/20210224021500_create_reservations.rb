class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|

      t.timestamps
    end
  end
end
