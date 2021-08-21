class Addregiontoparks < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :region, :string
  end
end
