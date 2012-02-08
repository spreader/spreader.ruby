class FBMarketingSocialUniqueClick
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :social_unique_clicks

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.social_unique_clicks.to_i
  end

end
