class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "book"

  def show
    @products_count = Product.count()
    @categories_count = Category.count()
  end
end
