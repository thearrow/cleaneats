class Place
  include Mongoid::Document
  field :id_citygrid, type: String
  field :id_yelp, type: String
  field :id_google, type: String
  field :latitude, type: String
  field :longitude, type: String
  embeds_one :rating, autobuild: true
  has_many :features

  def average_features
    #aggregate averages of all features for place
    match = {"$match" => {:place_id => self._id}}
    group = {"$group" => {:_id => self._id,
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
      self.rating = Rating.create(
          place: self,
          gluten: result['gluten'],
          msg: result['msg'],
          dairy: result['dairy'],
          vegan: result['vegan'],
          vegetarian: result['vegetarian'],
          paleo: result['paleo'],
          low_carb: result['low_carb']
      )
      self.save
    end
  end

end
