class HomeController < ApplicationController
    def index
        @restaurants = Restaurant.all
        render json: @restaurants
    end
end