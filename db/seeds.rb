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
        c = Campsite.from_json(campsite, park)

        c.restrictions = load_field(prov, campsite, 'restrictions', Restriction)
        c.conditions = load_field(prov, campsite, 'conditions', Condition)
        c.adjacent_tos = load_field(prov, campsite, 'adjacent_to', AdjacentTo)
        c.ground_covers = load_field(prov, campsite, 'ground_cover', GroundCover)
        c.allowed_equipments = load_field(prov, campsite, 'allowed_equipment', AllowedEquipment)
        c.obstructions = load_field(prov, campsite, 'obstructions', Obstruction)
        c.save!

        
        puts "... added #{count} valid sites (#{ix}/#{total} processed)" if ix % 100 == 0
    end
end

def load_field(prov, campsite, field, field_cls)
    Array(campsite.fetch(field, [])).map do |name|
        field_cls.find_or_create_by(prov: prov, name: name)
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


provs = %w(nb)

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
