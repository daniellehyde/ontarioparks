class RenameRegion < ActiveRecord::Migration[6.1]
  def change
    rename_column :parks, :region, :city
  end
end
