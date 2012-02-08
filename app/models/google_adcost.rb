class GoogleAdcost
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :ad_cost
  field :key
  
  
  metrics :adCost
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.ad_cost.to_f
  end   
end