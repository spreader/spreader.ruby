class FBMarketingImpression
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :impressions

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.impressions.to_i
  end

end
