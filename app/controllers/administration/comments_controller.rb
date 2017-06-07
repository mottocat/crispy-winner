module Administration
  class CommentsController < BaseController

    helper_method :sort_column

    def index
      @comments = Comment.order(sort_column + ' ' + sort_direction)
    end

    private

    def sort_column
      Comment.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end


  end
end