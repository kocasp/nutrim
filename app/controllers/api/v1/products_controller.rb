class Api::V1::ProductsController < ApplicationController
  api :GET, '/products', 'Pobierz listę produktów'
  param :query, String, desc: 'Slowo kluczowe, które Nutrim będzie wyszukiwal w swojej bazie produktów.', required: false
  def index
    products = Product.search(params[:query]).first(100)
    render json: products, status: :ok
  end
end
