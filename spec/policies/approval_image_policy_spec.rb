require "rails_helper"

RSpec.describe ApprovalImagePolicy do
  subject { described_class }

  let(:user) { double }
  let(:admin) { build_stubbed :admin }
  let(:approval_image) { double }

  permissions :index? do
    it "grant access" do
      expect(subject).to permit(admin, approval_image) 
    end
  end

  permissions :create? do
    it "grant access if user signed in" do
      expect(subject).to permit(user, approval_image) 
    end
  end

  permissions :update? do
    it "grant access" do
      expect(subject).to permit(user, approval_image) 
    end
  end

end