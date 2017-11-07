class BooksIndex < Chewy::Index
	define_type Book do
		field :title, :description
	end
end