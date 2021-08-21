class AddSubregionToParks < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :subregion, :string
  end
end
