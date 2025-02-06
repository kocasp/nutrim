class Api::V1::ProductsController < ApplicationController
  api :GET, '/products', 'Pobierz listę produktów'
  param :query, String, desc: 'Slowo kluczowe, które Nutrim będzie wyszukiwal w swojej bazie produktów.', required: false
  def index
    no_accent_query = I18n.transliterate(params[:query]).downcase if params[:query].present?
    products = Product.search(no_accent_query).limit(20)
    render json: products, status: :ok
  end
end
