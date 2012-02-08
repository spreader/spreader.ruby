class GoogleImpression
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :impressions
  field :key
  
  
  metrics :impressions 
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.impressions.to_i
  end   
end