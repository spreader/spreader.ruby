class Campaign
  include Mongoid::Document

  field :name
  field :description

  embeds_many :network

end
