class ApprovalImagesController < ApplicationController

  before_action :set_product
  before_action :set_approval_image, only: [:update]

  def index
    authorize ApprovalImage
  end

  def create
    @approval_image = ApprovalImage.new.tap do |ai|
      ai.user = current_user
      ai.product = @product
      ai.status = :waiting_approval
    end
    authorize @approval_image
    @approval_image.update(permitted_attributes(@approval_image))
    redirect_to @product
  end

  def update
    authorize @approval_image
    @approval_image.update(permitted_attributes(@approval_image))
    redirect_to @product
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_approval_image
    @approval_image = ApprovalImage.find(params[:id])
  end

end
