class Place
  include Mongoid::Document
  field :id_citygrid, type: String
  field :id_yelp, type: String
  field :id_google, type: String
  embeds_one :feature, autobuild: true
  has_many :features, after_add: :average_features

  def average_features(f)
      #mongo hasn't added place_id yet, manually add it
      f.place_id = self._id
      f.save!

      #aggregate averages of all features for place
      match = { "$match" => {:place_id => self._id} }
      group = { "$group" => {:_id => self.feature._id,
                             :gluten => {"$avg" => "$gluten"},
                             :msg => {"$avg" => "$msg"},
                             :dairy => {"$avg" => "$dairy"},
                             :vegan => {"$avg" => "$vegan"},
                             :vegetarian => {"$avg" => "$vegetarian"},
                             :paleo => {"$avg" => "$paleo"},
                             :low_carb => {"$avg" => "$low_carb"},
      }}
      results = Feature.collection.aggregate(match, group)

      #save averages to place's feature field
      unless results.empty?
        result = results.first
        result.keys.each do |attr|
          self.feature.attributes[attr] = result[attr]
        end
      end
  end

  def self.find_by_id(id)
    return Place.find_by(:_id => id)
  end
end
