class FBMarketingClick
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :clicks

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.clicks.to_i
  end

end
