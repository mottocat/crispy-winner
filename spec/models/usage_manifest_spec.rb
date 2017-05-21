require 'rails_helper'

RSpec.describe UsageManifest, type: :model do

  let(:user) { create :user }
  let(:product) { create :product }

  let(:approval_image) {
    create :approval_image, user: user, product: product
  }

  let(:usage_manifest) { 
    create :usage_manifest,
      user: user,
      product: product,
      approved_image: approval_image,
      status: :used
  }


  subject { usage_manifest }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :product }
  it { is_expected.to belong_to(:approved_image).
                     class_name("ApprovalImage").dependent(:destroy) }
  it { is_expected.to_not validate_presence_of :approved_image }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :product }
  it { is_expected.to validate_presence_of :status }

  it ".with_status" do
    another_usage_manifest = create :usage_manifest, status: :using
    expect(described_class.with_status(:used)).to be_include(usage_manifest)
    expect(described_class.with_status(:used)).to_not be_include(another_usage_manifest)
    expect(described_class.with_status(:using)).to be_include(another_usage_manifest)
    expect(described_class.with_status(:using)).to_not be_include(usage_manifest)
  end

  it "#status" do
    expect(subject).to be_used
    expect {
      subject.using!
    }.to change { subject.status }.to("using").from("used")
  end

  it "used status value" do
    expect(UsageManifest.statuses[:used]).to eq(0)
  end

  it "#need_approval?" do
    allow(subject).to receive(:approved_image)
    expect(subject).to_not be_need_approval
    allow(subject).to receive(:using?).and_return(true)
    expect(subject).to be_need_approval
  end

  it "#waiting_for_approval?" do
    allow(ApprovalImage).to receive(:find_by).with(user: user, product: product, status: :waiting_approval).and_return(double)
    expect(subject).to be_waiting_for_approval
  end

  it "After Destroy destroyes the own approval image" do
    approved_image = usage_manifest.approved_image
    usage_manifest.update!(approved_image: nil)

    usage_manifest.destroy
    expect { approved_image.reload }.
                      to raise_exception(ActiveRecord::RecordNotFound)
  end
end
