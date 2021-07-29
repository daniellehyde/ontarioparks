park_data = JSON.load (File.new('db/small_parks.json'))
park_data.each do |park|
    Park.new(external_park_id: park['park_id'], name: park['full_name'], city: park['address']['city']).save!
end

campsite_data = JSON.load (File.new('db/small_sites.json'))
campsite_data.each do |campsite|
    park = Park.where(external_park_id: campsite['park_id']).first
    Campsite.new(name: campsite['name'], quality: campsite['quality'], privacy: campsite['privacy'], park: park).save!
end