module Administration
  class BaseController < ApplicationController

    layout "administration"
    before_action :authorize_dasboard

    def index
    end

    private

    def authorize_dasboard
      authorize :dashboard, :index?
    end

  end
end