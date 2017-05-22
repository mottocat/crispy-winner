class UsageManifestsController < ApplicationController
  before_action :set_product
  before_action :set_usage_manifest


  def create
    @usage_manifest.update(usage_manifest_params)
    redirect_to stored_location_for(:user) || @product
  end

  def destroy
    @usage_manifest.destroy
    redirect_to stored_location_for(:user) || @product
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_usage_manifest
      @usage_manifest = UsageManifest.find_or_initialize_by(
        product: @product,
        user: current_user
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usage_manifest_params
      params.require(:usage_manifest).permit(:status)
    end
end
