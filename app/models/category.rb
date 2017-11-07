class Category < ApplicationRecord
	extend FriendlyId
	friendly_id :slug, use: :slugged

	has_many :books

	validates :name, :presence => true
	validates :name, :length => { :minimum => 3 }
end
