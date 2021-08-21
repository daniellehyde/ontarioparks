
SUBREGIONS = {
"Near North" => ["Arrowhead", "Chutes", "Driftwood", "Fairbank", "Finlayson Point", "French River", "Grundy Lake", "Halfway Lake", "Kap-Kig-Iwan", "Killarney", "Killbear", "List View", "Map View", "Marten River", "Mikisew", "Mississagi", "Oastler Lake", "Restoule", "Samuel de Champlain", "Six Mile Lake", "Spanish River", "Sturgeon Bay", "Temagami Cluster", "The Massasauga", "Windy Lake" ],
"Northern" => [ "Aaron", "Arrow Lake", "Batchawana Bay", "Blue Lake", "Caliper Lake", "Esker Lakes", "Fushimi Lake", "Ivanhoe Lake", "Kakabeka Falls", "Kettle Lakes", "Lake Superior", "List View", "MacLeod", "Map View", "Missinaibi", "Missinaibi (River)", "Nagagamisis", "Neys", "Ojibway", "Pakwash", "Pancake Bay", "Quetico", "Rainbow Falls", "Rene Brunelle", "Rushing River", "Sandbar Lake", "Silver Falls", "Sioux Narrows", "Sleeping Giant", "Tidewater", "Wabakimi", "Wakami Lake", "White Lake", "Woodland Caribou", ],
"Southwest and Central" => ["Awenda", "Balsam Lake", "Bass Lake", "Bronte Creek", "Craigleith", "Darlington", "Earl Rowe", "Emily", "Forks of the Credit", "Inverhuron", "Kawartha Highlands", "Long Point", "MacGregor Point", "Mara", "McRae Point", "Mono Cliffs", "Pinery", "Point Farms", "Port Burwell", "Rock Point", "Rondeau", "Sauble Falls", "Selkirk", "Sibbald Point", "Turkey Point", "Wheatley", ],
"Algonquin" => ["Achray", "Algonquin Backcountry", "Brent", "Canisbay Lake", "Hwy 60 Corridor", "Kingscote", "Kiosk", "Lake of Two Rivers", "List View", "Map View", "Mew Lake", "Pog Lake & Kearney Lake", "Rock Lake & Raccoon Lake", "Shall Lake", "Tea Lake", "Tim River", "Whitefish Lake",],
"Southeast" => [ "Bon Echo", "Bonnechere", "Charleston Lake", "Ferris", "Fitzroy", "Frontenac", "Lake St. Peter", "List View", "Map View", "Murphys Point", "North Beach", "Presqu'ile", "Rideau River", "Sandbanks", "Sharbot Lake", "Silent Lake", "Silver Lake", "Voyageur", ],
}

PARK_MAP = {}

SUBREGIONS.each do |subregion, parks|
    parks.each do |park|
        PARK_MAP[park] = subregion
    end
end

require 'json'
park_data = JSON.load (File.new('db/all_parks.json'))

park_data.each do |park|
    name = park['short_name']
    subregion = PARK_MAP[name]
    
    park['subregion'] = subregion
end

JSON.dump(park_data, File.new('out.json', 'w'))