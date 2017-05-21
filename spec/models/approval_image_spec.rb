require 'rails_helper'

RSpec.describe ApprovalImage, type: :model do

  let(:user) { create :user }
  let(:product) { create :product }
  let!(:usage_manifest) { create :usage_manifest, user: user, product: product }
  let(:approval_image) { create :approval_image, user: user, product: product }

  subject { approval_image }

  it { is_expected.to have_attribute(:image) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:product) }
  it { is_expected.to have_one(:usage_manifest).with_foreign_key("approved_image_id") }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:product_id) }

  describe "status" do
    it "#waiting_approval?" do
      expect(subject).to be_waiting_approval
    end

    it "#approved?" do
      subject.approved!
      expect(subject).to be_approved 
    end

    it "#denied?" do
      subject.denied!
      expect(subject).to be_denied 
    end
  end

  it "the usage manifest gets approved_image_id when approval image's the status is changed as approved" do
    usage_manifest.update!(approved_image_id: nil)
    subject.approved!
    usage_manifest.reload
    expect(usage_manifest.approved_image_id).to_not be_nil
  end

end
