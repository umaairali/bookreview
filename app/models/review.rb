class Review < ApplicationRecord
	extend FriendlyId
	friendly_id :slug, use: :slugged

	belongs_to :book
	belongs_to :user
end
