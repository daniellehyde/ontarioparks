class AddDataToCampsites < ActiveRecord::Migration[6.1]
  def change
    add_column :campsites, :category, :string
    add_column :campsites, :min_capacity, :int
    add_column :campsites, :max_capacity, :int
    add_column :campsites, :allowed_equipment, :text
    add_column :campsites, :site_shade, :string
    add_column :campsites, :conditions, :text
    add_column :campsites, :ground_cover, :text
    add_column :campsites, :pad_slope, :string
    add_column :campsites, :double_site, :string
    add_column :campsites, :adjacent_to, :text
    add_column :campsites, :service_type, :string
  end
end
