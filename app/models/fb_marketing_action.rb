class FBMarketingAction
  include Mongoid::Document
  include ChartLib
  field :date
  field :key
  field :actions

  def x 
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end

  def y
    self.actions.to_i
  end

end
