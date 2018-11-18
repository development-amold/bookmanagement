class Author
	include Mongoid::Document
	include Mongoid::Timestamps
	include ActiveModel::SecurePassword 

	field :name, type: String
	field :email, type: String
	field :password_digest, type: String
	field :author_bio, type: String
	field :pic, type: String
	field :academics, type: String
	field :awards, type: String
	has_many :books,:dependent => :destroy
	has_secure_password

	validates :name,:email, :presence => true


end