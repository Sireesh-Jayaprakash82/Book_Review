class BooksController < ApplicationController
    before_action :find_book, only: [:show, :update, :edit, :destroy]
    # before_action :find_price, only: [:show]
    def index
        # @a=HollaGem::Hola.greet.to_s
        if params[:category].blank?
            # @books = Book.includes(:price)
            # debugger
            @books = Book.eager_load(:price)
            # @books = Book.includes(:price).references(:price).where('Price.cost = ?', '1600')

        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("created_at DESC")
        end

        # @b = Book.all.includes(:price)
    end
    def show
        # debugger
        # @book = Book.find(params[:id])
        # @price = Price.find(@book.id==@price.book_id)
        # @book = Book.find(params[:id]).includes(:price)
        # @books = Book.includes(:price).references(:price).where('@book.price.cost = ?', '1600')
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
        @books = Book.includes(:price).references(:price).where('price.cost = ?', '1600')
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

    # def find_price
    #     # debugger
    #     # @price = Price.find_by(book_id: params[:id])
    # end
end
