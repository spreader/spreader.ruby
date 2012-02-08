class FBMarketingUniqueClick
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :unique_clicks

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.unique_clicks.to_i
  end

end
