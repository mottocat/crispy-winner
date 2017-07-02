class Forest::Product
  include ForestLiana::Collection

  collection :products

  field :title, type: 'String' do
    "#{object.brand} #{object.name}"
  end
end