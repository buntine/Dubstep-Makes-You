require 'yaml'
require Rails.root.join('lib','dubstep_makes_you')

namespace :dubstep do
  desc "Load genre fixture into database using nested sets"
  task :seed => :environment do
    genres = YAML.load_file Rails.root.join('db','genres.yml')
    DubstepMakesYou::Parsers.parse_genre genres
  end
end