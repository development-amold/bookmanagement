class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :rating, type: Integer
  field :title, type: String
  field :desc, type: String
  belongs_to :book

  validates :name,:desc, :presence => true

end
