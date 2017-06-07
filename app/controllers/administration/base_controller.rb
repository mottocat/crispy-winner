module Administration
  class BaseController < ApplicationController

    layout "administration"
    before_action :authorize_dasboard
    helper_method :sort_direction

    def index
    end

    private

    def authorize_dasboard
      authorize :dashboard, :index?
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

  end
end