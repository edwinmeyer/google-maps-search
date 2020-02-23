# Consuming the Google Map Search API in Ruby
## A demo app with partial RSpec test coverage

### *Edwin W. Meyer*
###  February 22, 2020

##  Introduction
*Google Map Search* is a simple Ruby application which demonstrates basic access of map data through the Google maps API. It is run from the command line and outputs the result returned by the API to the console. 
The command line arguments are the coordinates of the center of the search and the name of a search profile. A configuration file search_profiles.yml specifies search parameters for each of three search profiles,  Search Profile A,  Search Profile B, and  Search Profile C.
A partial set of Rspec tests is also provided.

## Command Line Invocation
Change directory to that containing the program files and issue, e.g.:   
```bash 
$ ruby map_search_main.rb 41.885033 -87.784500 'Search Profile A' 
```

## Output
The program output is simply that provided by the search API plus a heading specifying the input location and search profile name. A real application will undoubtedly further process this returned data.
Sample output files of the form search_profile_a_output.txt are provided for for all three search profiles. The location used (latitude 41.885033, longitude -87.78450) is in Oak Park, Illinois.

## Search Radius
The search radius parameter is hard-wired as 1000 meters in the url generation in the *GoogleMapsSearch* class. One possible added feature would make this specifiable either in the command line or the search profile parameters. The default value would be used if not specified.

## Rspec Tests
A partial set of Rspec tests for the *GoogleMapsSearch* class is provided.
See the accompanying file *rspec-output.txt* for a sample run.

## Google API Key
The Google API Key is a per-user key provided by Google. It must be stored in the YAML file *google_api_key.yml*. The version provided here has the key redacted. A valid key must be substituted.
See the 'Get the API key' section of https://developers.google.com/places/web-service/get-api-key for information about obtaining a Google API Key.

## Files Comprising the Application
*search_profile.rb* – The SearchProfile class retrieves the search profile by name and returns its map parameters.   
*search_profiles.yml* – Contains parameter data which governs the search output – accessed through the SearchProfile class.   
*google_api_key.yml* – Contains the user’s Google API Key – provided by Google. The provided file has the key redacted.   
*google_maps_search.rb* – Implements the *GoogleMapsSearch* class. Formats the search url using a supplied location and search parameters. Dispatches the url as an HTTP get request and returns the output. Also provides a class method for validating the location.   
*map_search_main.rb* – The main program for command line invocation of this application.   
*spec/google_maps_search_spec.rb* – Rspec tests for *google_maps_search.rb*   
