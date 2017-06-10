require 'rails_helper'

RSpec.describe Product, type: :model do

  subject { create :product }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :brand }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :brand }

  it { is_expected.to have_many :comments }

  it ".search" do
    xyz = create :product, name: "XYZ Mobile"
    abc = create :product, brand: "ABC Biscuits"
    expect(described_class.search("XYZ")).to be_include(xyz)
    expect(described_class.search("ABC")).to be_include(abc)
  end
end
