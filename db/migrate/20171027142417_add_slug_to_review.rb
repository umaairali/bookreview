class AddSlugToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :slug, :string
    add_index :reviews, :slug, unique: true
  end
end
