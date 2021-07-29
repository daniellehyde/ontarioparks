class CreateCampsites < ActiveRecord::Migration[6.1]
  def change
    create_table :campsites do |t|
      t.string :name
      t.string :quality
      t.string :privacy
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
