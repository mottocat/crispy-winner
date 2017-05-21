class ApprovalImagesController < ApplicationController

  before_action :set_product
  before_action :set_approval_image, only: [:create, :update]

  def index
    authorize ApprovalImage
  end

  def create
    authorize @approval_image
    @approval_image.status = :waiting_approval
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
    @approval_image = ApprovalImage.find_or_initialize_by(
                                user: current_user, product: @product)
  end

end
