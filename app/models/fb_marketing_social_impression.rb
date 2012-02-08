class FBMarketingSocialImpression
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :social_impressions

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.social_impressions.to_i
  end

end
