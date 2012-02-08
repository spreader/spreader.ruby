class Network
  include Mongoid::Document

  field :user_id
  field :network_id
  field :app_id
  field :secret, :type => String
  field :access_token, :type => String

  embedded_in :campaign, :inverse_of => :networks
end
