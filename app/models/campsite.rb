class Campsite < ApplicationRecord
  belongs_to :park

  has_and_belongs_to_many :restrictions
  has_and_belongs_to_many :equipment

  def self.from_json(campsite, park)
    Campsite.new(
      park: park,
      name: campsite['name'],
      quality: campsite['quality'],
      privacy: campsite['privacy'],
      category: campsite['category'],
      min_capacity: campsite['min_capacity'],
      max_capacity: campsite['max_capacity'],
      double_site: campsite['double_site'],
      service_type: campsite['service_type'],
      pad_slope: campsite['pad_slope'],
      site_shade: campsite['site_shade']
    )
  end

end