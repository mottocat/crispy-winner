class ProductUsagesController < ApplicationController
  before_action :set_product_usage, only: [:show, :edit, :update, :destroy]

  # GET /product_usages
  # GET /product_usages.json
  def index
    @product_usages = ProductUsage.all
  end

  # GET /product_usages/1
  # GET /product_usages/1.json
  def show
  end

  # GET /product_usages/new
  def new
    @product_usage = ProductUsage.new
  end

  # GET /product_usages/1/edit
  def edit
  end

  # POST /product_usages
  # POST /product_usages.json
  def create
    @product_usage = ProductUsage.new(product_usage_params.merge(user: current_user))
    @product_usage.user = current_user

    respond_to do |format|
      if @product_usage.save
        format.html { redirect_to @product_usage, notice: 'Product usage was successfully created.' }
        format.json { render :show, status: :created, location: @product_usage }
      else
        format.html { render :new }
        format.json { render json: @product_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_usages/1
  # PATCH/PUT /product_usages/1.json
  def update
    respond_to do |format|
      if @product_usage.update(product_usage_params)
        format.html { redirect_to @product_usage, notice: 'Product usage was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_usage }
      else
        format.html { render :edit }
        format.json { render json: @product_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_usages/1
  # DELETE /product_usages/1.json
  def destroy
    @product_usage.destroy
    respond_to do |format|
      format.html { redirect_to product_usages_url, notice: 'Product usage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_usage
      @product_usage = ProductUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_usage_params
      params.require(:product_usage).permit(:product_name, :usage_status, {images: []}, :comment_body)
    end
end
