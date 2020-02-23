class GoogleMapsSearch
  require 'net/http'
  require 'uri'

  def initialize(api_key)
    @api_key = api_key
  end

  def self.check_params(latitude, longitude)
    [['latitude', latitude, 90], ['longitude', longitude, 180]].each do |label, coord, limit|
      raise "#{label }: Bad format #{coord }" unless coord =~ /\A\-?\d+(\.\d+)?\z/
      raise "#{label }: Out of bounds value #{coord }" unless (-limit.to_f..limit.to_f) === coord.to_f
    end
  end

  def execute(location, search_params)
    url = compose_search_url(location, search_params)
    http_get_request(url)
  end

  def compose_search_url(location, search_params)
    radius = 1000 # search within this distance (meters) of location
    # search_params has string keys
    "https://maps.googleapis.com/maps/api/place/nearbysearch/#{search_params['output_format']}?" +
       "language=#{search_params['language_code']}&location=#{location['latitude']}," +
       "#{location['longitude']}&radius=#{radius}&types=#{search_params['type']}&key=#{@api_key}"
  end

  private

  def http_get_request(url)
    uri = URI.parse(url)
    Net::HTTP.get(uri)
  end
end
