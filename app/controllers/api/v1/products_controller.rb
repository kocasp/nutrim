require 'pry-remote'
class Api::V1::ProductsController < ApplicationController
    def index
      products = Product.search(params[:query]).first(20)
      render json: products, status: :ok
    end
end