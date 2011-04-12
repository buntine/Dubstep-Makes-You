module DubstepMakesYou
  extend self
  
  attr_reader :echonest_api_key,
              :lastfm_api_key,
              :lastfm_api_secret
  
  def load_config(path)
    file = YAML.load_file path
    @echonest_api_key  = file['echonest']['api_key']
    Rockstar.lastfm=file['lastfm']
  end
  
  def is_setup?
    if(@echonest_api_key.nil? || Rockstar.lastfm_api_key.nil? || Rockstar.lastfm_api_key.nil?)
      return false
    else
      return true
    end
  end
  
  class LastFM
    attr_reader :user
    
    def initialize(username)
      @user = Rockstar::User.find(username)
    end
    
    def top_artists(limit=10)
      @user.top_artists.slice(0,limit).collect(&:name)
    end
    
    def genres
      EchoNest.get_terms_from_artists top_artists
    end
  end
  
  class EchoNest
    include HTTParty
    base_uri 'developer.echonest.com'
    
    def self.get_terms_from_artist(artist)
      artist = artist.class == String ? artist : artist.name
      request = get '/api/v4/artist/terms', { :query => {
        :api_key => DubstepMakesYou.echonest_api_key,
        :format  => 'json',
        :name    => artist
      }}
      terms = request['response']['terms']
      terms.collect{ |term| term['name'] }.flatten.uniq
    end
    
    def self.get_terms_from_artists(artists)
      artists.collect { |artist| get_terms_from_artist artist }.flatten
    end
  end
end