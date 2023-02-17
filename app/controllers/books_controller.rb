class BooksController < ApplicationController
    before_action :find_book, only: [:show, :update, :edit, :destroy]
    def index
        if params[:category].blank?
            @books = Book.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("created_at DESC")
        end
    end
    def show
        # @book = Book.find(params[:id])
    end
    def new
        # debugger
        @book = current_user.books.build
        @book.build_price
        @book.build_price.user_id = current_user.id
        @categories = Category.all.map{ |c| [c.name, c.id]}
    end
    def create
        # debugger
        @book = current_user.books.build(book_params)
        @price=@book.build_price(price_params)
        @price.user_id = current_user.id
        @book.category_id = params[:category_id]
        # debugger
        if @book.save and @price.save
            redirect_to root_path
        else
            render 'new'
        end
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
    
    def edit
        @categories = Category.all.map { |c| [c.name, c.id]}
    end

    private
    
    def book_params
        params.require(:book).permit(:title, :description,  :author, :category_id, price_attributes: [:cost, :pages])
    end

    def price_params
        params.require(:book).require(:price_attributes).permit(:cost, :pages, :book_id, :user_id )
    end


    def find_book
        @book = Book.find(params[:id])
    end
end
