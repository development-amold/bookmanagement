class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :short_desc, type: String
  field :long_desc, type: String
  field :chapter_index, type: String
  field :publish_date, type:  Date
  belongs_to :author
  has_many :reviews,:dependent => :destroy
  validates :name, :presence => true


end
