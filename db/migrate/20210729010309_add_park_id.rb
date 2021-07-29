class AddParkId < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :external_park_id, :int
  end
end
