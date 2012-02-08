class FBMarketingSpent
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :spent

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.spent.to_i
  end

end
