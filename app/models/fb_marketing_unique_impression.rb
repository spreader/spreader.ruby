class FBMarketingUniqueImpression
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :unique_impressions

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.unique_impressions.to_i
  end

end
