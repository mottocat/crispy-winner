module Administration
  class ProductsController < BaseController

    helper_method :sort_column

    def index
      @products = Product.order(sort_column + ' ' + sort_direction)
    end

    private

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end


  end
end