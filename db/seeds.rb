Campsite.delete_all
Park.delete_all
park_data = JSON.load (File.new('db/all_parks.json'))
park_data.each do |park|
    Park.new(
        external_park_id: park['park_id'],
        name: park['full_name'],
        city: park['address']['city'],
        region: park['address']['region'],
        subregion: park['subregion'],
        website: park['website'],
    ).save!
end

puts "... added #{Park.count} parks"

campsite_data = JSON.load (File.new('db/all_sites.json'))
total = campsite_data.length

count = 0
campsite_data.each_with_index do |campsite, ix|
    park = Park.where(external_park_id: campsite['park_id']).first

    next unless campsite['category'] == 'Campsite'
    next if campsite['quality'] == 'Poor' or campsite['privacy'] == 'Poor'
    next if campsite['quality'] == 'Average' and campsite['quality'] == 'Average'
    next if campsite['allowed_equipment'].empty? 

    count += 1
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
    
    puts "... added #{count} valid sites (#{ix}/#{total} processed)" if ix % 100 == 0
end


orphans = Park.all.select { |p| p.campsites.count == 0 }
Park.where(id: orphans.map(&:id)).delete_all
puts "... removed #{orphans.count} parks with no sites"
puts ""

puts "Campsites: #{Campsite.count}"
puts "    Parks: #{Park.count}"
