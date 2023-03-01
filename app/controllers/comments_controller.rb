class CommentsController < ApplicationController
    before_action :find_book, except: %i[index]
    def index
        @comment = Comment.find_comments("Sireesh")
    end

    def new
        # debuggerx
        @comment = Comment.new
    end 

    def create
        @comment = Comment.new(comment_params)
        @comment.book_id = @book.id
        @comment.user_id = current_user.id
        if @comment.save
            render turbo_stream: 

                [                
                    turbo_stream.append('comment_display',
                    partial: "comments/comment",
                    locals: { comment: @comment })
                ]  
        else
            render 'new'
        end
    end

    def review
        # Turbo::StreamsChannel.broadcast_update_to("mystr", target: "content", partial: "comments/form", locals: { comment: @book })
        # render partial: "comments/form", locals: { comment: @book }
    end

    private

    def comment_params
        params.require(:comment).permit(:name, :description)
    end

    def find_book
        @book = Book.find(params[:book_id])
    end
    
end
