class Feature
  include Mongoid::Document
  field :gluten, type: Float
  field :msg, type: Float
  field :dairy, type: Float
  field :vegan, type: Float
  field :vegetarian, type: Float
  field :paleo, type: Float
  field :low_carb, type: Float
  belongs_to :place
  belongs_to :user

  def set_user(user)
    self.user = user
  end

end
