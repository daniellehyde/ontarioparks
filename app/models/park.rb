class Park < ApplicationRecord
    has_many :campsites

    def self.from_json(park)
        Park.new(
            external_park_id: park['park_id'],
            name: park['full_name'],
            city: park['address']['city'],
            subregion: park['address']['region'],
            website: park['website'],
            description: park['description'],
        )
    end

end
