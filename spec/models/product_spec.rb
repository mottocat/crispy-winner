require 'rails_helper'

RSpec.describe Product, type: :model do


  let(:valid_attributes) {
    {
      name: "The Product Name",
      brand: "The Brand Name"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: ""
    }
  }

  subject { Product.new valid_attributes }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :brand }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :brand }

end
