class Book < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged

	belongs_to :user
	belongs_to :category
	has_many :reviews
	has_many :publishers
	has_many :authors, through: :publishers

	has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

  	validates :title, :description, :presence => true
end
