class CreateRestrictions < ActiveRecord::Migration[6.1]
  def change
    create_table :restrictions do |t|
      t.string :name
      t.timestamps
    end
  end
end
