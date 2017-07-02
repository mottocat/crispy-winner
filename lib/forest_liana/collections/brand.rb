class Forest::Brand
  include ForestLiana::Collection

  collection :brands
  field :brand, type: 'String'
  field :count, type: 'Number'
end