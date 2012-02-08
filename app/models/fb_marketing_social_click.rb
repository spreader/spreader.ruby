class FBMarketingSocialClick
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :social_clicks

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.social_clicks.to_i
  end

end
