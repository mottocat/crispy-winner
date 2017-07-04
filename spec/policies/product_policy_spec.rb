require 'rails_helper'

RSpec.describe ProductPolicy do
  
  subject { described_class }

  let(:user) { build_stubbed :user }
  let(:product) { double }
  let(:admin) { build_stubbed :admin }

  permissions :show? do
    it "grant access" do
      expect(subject).to permit(user, product)
    end
  end

  permissions :new? do
    it "grant access" do
      expect(subject).to_not permit(user, product)
      expect(subject).to permit(admin, product)
    end
  end

  permissions :create? do
    it "grant access" do
      expect(subject).to permit(admin, product)
      expect(subject).to_not permit(user, product)
    end
  end

  permissions :edit? do
    it "grant access" do
      expect(subject).to_not permit(user, product)
      expect(subject).to permit(admin, product)
    end
  end

  permissions :update? do
    it "grant access" do
      expect(subject).to_not permit(user, product)
      expect(subject).to permit(admin, product)
    end
  end

  permissions :destroy? do
    it "grant access" do
      expect(subject).to_not permit(user, product)
      expect(subject).to permit(admin, product)
    end
  end

end