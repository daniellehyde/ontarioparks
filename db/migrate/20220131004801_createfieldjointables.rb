class Createfieldjointables < ActiveRecord::Migration[6.1]
  def change
    create_join_table :campsites, :conditions do |t|
      t.index :campsite_id
      t.index :condition_id
    end
    create_join_table :campsites, :adjacent_tos do |t|
      t.index :campsite_id
      t.index :adjacent_to_id
    end
    create_join_table :campsites, :ground_covers do |t|
      t.index :campsite_id
      t.index :ground_cover_id
    end
    create_join_table :campsites, :allowed_equipments do |t|
      t.index :campsite_id
      t.index :allowed_equipment_id
    end
    create_join_table :campsites, :obstructions do |t|
      t.index :campsite_id
      t.index :obstruction_id
    end
  end
end
