class Forest::User
  include ForestLiana::Collection

  collection :users

  field :name, type: 'String' do
    "#{object.first_name} #{object.last_name}"
  end

  field :display, type: 'String' do
    "#{object.first_name} #{object.last_name} <#{object.email}>"
  end
end