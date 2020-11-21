module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index, :search]  
      before_action :set_restaurant, only: [:show, :update, :destroy]

      
      def index
        @restaurants = Restaurant.all
        render json: @restaurants
      end
      def show
        render json: @restaurant
      end

      
      def create
        
        @restaurant = Restaurant.new(restaurant_params)
        if @restaurant.save
          render json: @restaurant, status: :created
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end

      def search
        if params[:search].blank?
          @restaurant = Restaurant.all
          render json: @restaurant
        else
          @restaurant = Restaurant.search(params)
          render json: @restaurant
        end
      end

      
      def update
        if @restaurant.update(restaurant_params)
          render json: @restaurant
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @restaurant.destroy
      end

      private

        def set_restaurant
          @restaurant = Restaurant.find(params[:id])
        end
        
        def restaurant_params
          params.permit(:nom_restaurant, :prix, :adress, :photo_file, :speciality, :users_id)
        end
    end
  end
end