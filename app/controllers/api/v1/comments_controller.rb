module Api
    module V1
        class CommentsController < ApplicationController  
            def index
                @comments = Comment.where(restaurant_id: "#{params[:restaurant_id]}")
                render json: @comments
            end

            def create
                @comments = Comment.new(comment_params)
                if @comments.save
                    render json: @comments, status: :created
                  else
                    render json: @comments.errors, status: :unprocessable_entity
                  end
            end

            def comment_params
                params.permit(:comment, :restaurant_id, :user_id)
            end
        end
    end
end
