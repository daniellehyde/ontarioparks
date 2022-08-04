class AddProvToRestrictions < ActiveRecord::Migration[6.1]
  def change
    add_column :restrictions, :prov, :string
    add_column :restrictions, :category, :string
  end
end
