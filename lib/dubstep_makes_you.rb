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
  
  class GitHub
    attr_reader :user
    
    def initialize(username)
      @user = Octopi::User.search(username).first
    end
    
    def popularity
      user.followers.length + user.repos
    end
  
    def seconds_since_last_commit
      last_push = Time.parse user.pushed
      now       = Time.now
      (now - last_push).round
    end
  
    def minutes_since_last_commit
      (seconds_since_last_commit / 60).round
    end
  
    def hours_since_last_commit
      (minutes_since_last_commit / 60).round
    end
  
    def days_since_last_commit
      (hours_since_last_commit / 24).round
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
  
  class Parsers    
    def self.parse_genre(obj,parent=nil)
      if obj.class == String
        # puts parent.nil? ? "#{obj}" : "#{parent} / #{obj}"
        if parent.nil?
          Genre.create!(:name => key)
        else
          parent = Genre.find_by_name(parent) unless parent.nil?
          parent.children.create!(:name => obj)
        end
      elsif obj.class == Hash
        obj.each do |key,value|
          # puts parent.nil? ? "#{key}" : "#{parent} / #{key}"
          if parent.nil?
            genre = Genre.create(:name => key)
            genre.save
          else
            parent = Genre.find_by_name(parent)
            parent.children.create!(:name => key)
          end
          self.parse_genre(value,key)
        end
      elsif obj.class == Array
        obj.each do |value|
          self.parse_genre(value,parent)
        end
      end
    end
  end
end