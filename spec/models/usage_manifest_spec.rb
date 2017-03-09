require 'rails_helper'

RSpec.describe UsageManifest, type: :model do

  let(:user) { create :user }
  let(:product) { create :product }

  let(:usage_manifest) { 
    create :usage_manifest,
      user: user,
      product: product,
      status: :used
  }

  subject { usage_manifest }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :product }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :product }
  it { is_expected.to validate_presence_of :status }

  it "enum" do
    expect(subject).to be_used
    expect {
      subject.using!
    }.to change { subject.status }.to("using").from("used")
  end

  it "used status value" do
    expect(UsageManifest.statuses[:used]).to eq(0)
  end

  it "status scope" do
    expect(described_class.with_status(:used)).to eq([usage_manifest])
    expect(described_class.with_status(:using)).to_not eq([usage_manifest])

    usage_manifest.update(status: :using)
    expect(described_class.with_status(:used)).to_not eq([usage_manifest])
    expect(described_class.with_status(:using)).to eq([usage_manifest])
  end 

end
