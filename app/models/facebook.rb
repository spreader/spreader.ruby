class Facebook
  include Mongoid::Document

  field :app_id
  field :name
  field :values, :type => Array
  field :description

end

class GenderAndAge
  include Mongoid::Document

  field :gender
  field :age_range

end