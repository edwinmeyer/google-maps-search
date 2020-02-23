# Main program

require 'yaml'
require_relative 'google_maps_search'
require_relative 'search_profile'

latitude, longitude, search_profile_name = ARGV
GoogleMapsSearch.check_params(latitude, longitude)

location = {'latitude'=>latitude, 'longitude'=>longitude}
search_profile = SearchProfile.new(search_profile_name)
search_params = search_profile.map_search_params()

api_key = YAML.load_file('google_api_key.yml')['api_key']
search = GoogleMapsSearch.new(api_key)
response = search.execute(location, search_params)

puts "Google Maps Search near latitude #{latitude}, longitude #{longitude} for #{search_profile_name}:\n\n"
puts response
