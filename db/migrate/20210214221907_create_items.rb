class CreateItem < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :category_id, null: false
      t.text :detail
      t.integer :location_id, null: false
      t.integer :department_id, null: false
      t.date :purchase_date
      t.references :user, foreign_key: true      

      t.timestamps
    end
  end
end