class GoogleRoi
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :roi
  field :key
  
  
  metrics :ROI
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.roi.to_f
  end   
end