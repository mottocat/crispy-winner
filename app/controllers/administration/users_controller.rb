module Administration
  class UsersController < BaseController

    helper_method :sort_column

    def index
      @users = User.order(sort_column + ' ' + sort_direction)
    end

    private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end


  end
end