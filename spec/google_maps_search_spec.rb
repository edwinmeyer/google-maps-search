require_relative '../google_maps_search'

RSpec.describe 'GoogleMapsSearch' do
  context 'check_params' do
    it 'raises no error with valid latitude & longitude' do
      latitude = '30.4284750'
      longitude = '-97.7550500'
      expect{ GoogleMapsSearch.check_params(latitude, longitude) }.not_to raise_error
    end

    [ ['invalid latitude', '53.87'], ['45.77', 'invalid longitude'],
      ['91', '53.87'], ['-91', '53.87'], ['45.77', '181'], ['45.77', '-181']

    ].each do |lat, lon|
      it "raises an error for #{lat},#{lon}" do
        expect{ GoogleMapsSearch.check_params(lat, lon) }.to raise_error(RuntimeError)
      end
    end
  end
  
  context 'compose_search_url has correct components' do
    let(:gms) { GoogleMapsSearch.new('dummmy api key') }
    let(:location) do
      {'latitude'=>'41.885033', 'longitude'=>'-87.784500'}
    end
    let(:url) do
      # Note: locations_count is not used
      search_params = {'name'=>'Search Profile B', 'type'=>'bank', 'language_code'=>'es',
                       'output_format'=>'json', 'locations_count'=>20}
      gms.compose_search_url(location, search_params)
    end

    it "sets the type as 'bank'" do
      expect(url.include? 'types=bank').not_to be nil
    end

    it "sets the language as 'es'" do
      expect(url.include? 'language=es').not_to be nil
    end

    it "sets the output format as 'json'" do
      expect(url.include? 'nearbysearch/json?').not_to be nil
    end

    it "correctly sets the location" do
      expect(url.include? "location=#{location['latitude']},#{location['longitude']}").not_to be nil
    end

    it "sets a valid radius" do
      # A 1000 meter radius is currently hard-wired into the code
      expect(url =~ /radius=\d+/).not_to be nil
    end
  end
end
