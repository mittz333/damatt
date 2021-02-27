class AddControlNumberToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :control_number, :string
    change_column :items, :name, :string
  end
end