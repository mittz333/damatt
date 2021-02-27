class ChangeNameToItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :name, :string, null: true
  end
end
