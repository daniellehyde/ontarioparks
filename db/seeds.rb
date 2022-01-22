def remove_orphans
    orphans = Park.all.select { |p| p.campsites.count == 0 }
    Park.where(id: orphans.map(&:id)).delete_all
    puts "... removed #{orphans.count} parks with no sites"
end

def load_parks(park_data)
    park_data.each do |park|
        Park.from_json(park).save!
    end
    puts "... added #{Park.count} parks"
end

def load_campsites(prov, campsite_data)
    total = campsite_data.length
    count = 0
    campsite_data.each_with_index do |campsite, ix|
        park = Park.where(external_park_id: campsite['park_id']).last

        #next unless campsite['category'] == 'Campsite'
        next if campsite['allowed_equipment'].empty? 

        count += 1
        Campsite.from_json(campsite, park).save!
        
        puts "... added #{count} valid sites (#{ix}/#{total} processed)" if ix % 100 == 0
    end
end

def load_for_province(prov, park_data, campsite_data)
    load_parks(park_data)
    load_campsites(prov, campsite_data)
    # remove_orphans

    puts "Campsites: #{Campsite.count}"
    puts "    Parks: #{Park.count}"
end

puts ""


provs = %w(ns nb nl)

Campsite.delete_all
Park.delete_all
provs.each do |prov|
    puts "--- #{prov} ---"
    park_data = JSON.load(File.new("data/#{prov}-parks.json"))
    campsite_data = JSON.load(File.new("data/#{prov}-campsites.json"))

    load_for_province(prov, park_data, campsite_data)
end

puts "Campsites: #{Campsite.count}"
puts "    Parks: #{Park.count}"
