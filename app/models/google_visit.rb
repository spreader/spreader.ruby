class GoogleVisit 
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :visit_count
  field :key
  
  
  metrics :visitors
  dimensions :date, :visit_count
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.visit_count.to_i
  end
  

end