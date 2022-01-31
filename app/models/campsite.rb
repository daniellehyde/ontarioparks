class Campsite < ApplicationRecord
  belongs_to :park

  has_and_belongs_to_many :restrictions
  has_and_belongs_to_many :conditions
  has_and_belongs_to_many :adjacent_tos
  has_and_belongs_to_many :ground_covers
  has_and_belongs_to_many :allowed_equipments
  has_and_belongs_to_many :obstructions

  def self.from_json(campsite, park)
    Campsite.new(
      park: park,
      name: campsite['name'],
      quality: campsite['quality'],
      privacy: campsite['privacy'],
      category: campsite['category'],
      min_capacity: campsite['min_capacity'],
      max_capacity: campsite['max_capacity'],
      allowed_equipment: campsite['allowed_equipment'],
      double_site: campsite['double_site'],
      service_type: campsite['service_type'],
      #adjacent_to: campsite['adjacent_to'],
      #conditions: campsite['conditions'],
      #ground_cover: campsite['ground_cover'],
      pad_slope: campsite['pad_slope'],
      site_shade: campsite['site_shade']
    )
  end

end