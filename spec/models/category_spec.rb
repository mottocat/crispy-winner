require "rails_helper"

RSpec.describe Category, type: :model do
  
  subject { create :category }

  it { is_expected.to have_attribute :name }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many(:products).dependent(:nullify) }

end