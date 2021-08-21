class Addwebsites < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :website, :string
  end
end
