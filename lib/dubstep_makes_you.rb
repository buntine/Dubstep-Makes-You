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
end