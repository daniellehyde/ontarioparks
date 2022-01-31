class CreateCampsitesRestrictionsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :campsites, :restrictions do |t|
      t.index :campsite_id
      t.index :restriction_id
    end
  end
end
