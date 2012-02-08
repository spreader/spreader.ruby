class FBMarketingSocialSpent
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :social_spent

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.social_spent.to_i
  end

end
