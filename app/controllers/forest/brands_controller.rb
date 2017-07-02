class Forest::BrandsController < ForestLiana::ApplicationController
  def index
    brands = ::Product.all
      .group(:brand)
      .order(:brand)
      .count
      .map.with_index do |f, index|
        {
          id: index,
          type: 'brands',
          attributes: {
            brand: f.first,
            count: f.second
          }
        }
      end

    render json: { data: brands }
  end
end