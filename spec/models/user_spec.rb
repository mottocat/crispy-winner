require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create :user }
  let(:product) { create :product }

  it { is_expected.to have_attribute :name }

  it { is_expected.to have_many :usage_manifests }
  it { is_expected.to have_many :products }

  it "#use!" do
    manifest = user.use! product, status: :using
    expect(manifest).to be_using

    manifest = user.use! product, status: :used
    expect(manifest).to be_used
  end

  it "#usage_manifest_for" do
    expect(user.usage_manifest_for(product)).to be_nil

    user.use! product
    expect(user.usage_manifest_for(product)).to_not be_nil
  end

  it "#usage_status" do
    expect(user.usage_status(product)).to be_nil

    manifest = user.use! product, status: :using
    expect(user.usage_status(product)).to eq("using")

    manifest = user.use! product, status: :used
    expect(user.usage_status(product)).to eq("used")
  end

end
