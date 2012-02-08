class FBMarketingConnection
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :connections

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.connections.to_i
  end

end
