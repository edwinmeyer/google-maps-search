require 'yaml'

class SearchProfile
  def initialize(search_profile_name)
    search_profiles = YAML.load_file("search_profiles.yml")
    @search_params = search_profiles['search_profiles'].select { |c| c['name'] == search_profile_name }.first
    raise "SearchProfile '#{search_profile_name}' not found" unless @search_params
  end

  def map_search_params
    @search_params
  end
end
