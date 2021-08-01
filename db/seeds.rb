Campsite.delete_all
Park.delete_all
park_data = JSON.load (File.new('db/all_parks.json'))
park_data.each do |park|
    Park.new(external_park_id: park['park_id'], name: park['full_name'], city: park['address']['city']).save!
end


campsite_data = JSON.load (File.new('db/all_sites.json'))
campsite_data.each do |campsite|
    park = Park.where(external_park_id: campsite['park_id']).first
    puts campsite
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
        adjacent_to: campsite['adjacent_to'],
        conditions: campsite['conditions'],
        ground_cover: campsite['ground_cover'],
        pad_slope: campsite['pad_slope'],
        site_shade: campsite['site_shade']
        ).save!
end


