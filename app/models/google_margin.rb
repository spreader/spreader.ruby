class GoogleMargin
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :margin
  field :key
  
  
  metrics :margin
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.margin.to_f
  end  
end
