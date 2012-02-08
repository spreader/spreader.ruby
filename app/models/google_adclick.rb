class GoogleAdclick
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :ad_clicks
  field :key
  
  
  metrics :adClicks  
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.ad_clicks.to_i
  end
  
end