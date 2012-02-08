class GoogleCpc
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :cpc
  field :key
  
  
  metrics :CPC
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.cpc.to_f
  end    
end