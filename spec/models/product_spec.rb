require 'rails_helper'

RSpec.describe Product, type: :model do

  subject { create :product }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :image }
  it { is_expected.to have_attribute :brand }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :brand }

  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:usage_manifests).dependent(:destroy) }

  it ".search" do
    xyz = create :product, name: "XYZ Mobile"
    abc = create :product, brand: "ABC Biscuits"
    expect(described_class.search("XYZ")).to be_include(xyz)
    expect(described_class.search("ABC")).to be_include(abc)
  end

  it "#display" do
    product = create :product, brand: "Brand", name: "Product"
    expect(product.display).to eq('Brand Product')
  end
end
