module Administration
  class UsageApprovalsController < BaseController

    helper_method :sort_column

    def index
      @approval_images = ApprovalImage.order(sort_column + ' ' + sort_direction)
    end

    private

    def sort_column
      ApprovalImage.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end


  end
end