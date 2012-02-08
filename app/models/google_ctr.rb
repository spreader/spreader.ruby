class GoogleCtr
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :ctr
  field :key
  
  
  metrics :CTR
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.ctr.to_f
  end   
end