class GoogleRpc
  extend Garb::Model
  
  include Mongoid::Document
  include ChartLib
  
  field :date
  field :rpc
  field :key
  
  
  metrics :RPC
  dimensions :date
  
  def x
    DateTime.parse(self.date).strftime("%m/%d/%Y")
  end
  
  def y
    self.rpc.to_f
  end   
end