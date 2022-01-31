class Createfields < ActiveRecord::Migration[6.1]
  def change
    create_table :conditions do |t|
      t.string :name
      t.string :prov
      t.timestamps
    end

    create_table :adjacent_tos do |t|
      t.string :name
      t.string :prov
      t.timestamps
    end

    create_table :ground_covers do |t|
      t.string :name
      t.string :prov
      t.timestamps
    end

    create_table :allowed_equipments do |t|
      t.string :name
      t.string :prov
      t.timestamps
    end

    create_table :obstructions do |t|
      t.string :name
      t.string :prov
      t.timestamps
    end
  end
end
