class YoutubeChannelData
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :views
  field :unique_users_30
  field :subscriptions
  field :comments
  field :favorites
  field :key
  
  
  def x
    self.date.strftime("%m/%d/%Y")
  end
  
  def y
    self.views.to_i
  end
  
end