class BooksController < ApplicationController

  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, onlye: [:new, :edit]

  def index
    if params[:category].blank?
      # @books = Book.all.order("created_at DESC")
      @books = Book.paginate(:page => params[:page], per_page: 2)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order("created_at DESC").paginate(:page => params[:page], per_page: 2)
    end
  end

  def show
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  def new
    @book = current_user.books.build
    # @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      publishers = params[:book][:author_id]
      publishers.each do |pub|
        if !pub.empty?
          Publisher.create(author_id: pub, book_id: @book.id)
        end
      end
      redirect_to root_path
    else
      render "new"
      # redirect_to new_book_path, :flash => { :error => @book.errors.full_messages.join(', ') }
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @book.category_id = params[:category_id]
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :description, :category_id, :book_img, :slug, :author_id)
    end

    def find_book
      @book = Book.friendly.find(params[:id])
    end

end
