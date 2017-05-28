require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class }

  let(:user) { create :user }
  let(:product) { create :product }
  let(:comment) { create :comment, product: product, author: user }

  permissions :new? do
    it "grant access" do
      allow(user).to receive(:has_comment_on?).and_return(false)
      expect(subject).to permit(user, comment) 
    end
  end

  permissions :create? do
    it "grant access" do
      allow(user).to receive(:has_comment_on?).and_return(false)
      expect(subject).to permit(user, comment) 
    end
  end

  permissions :update? do
    it "grant access" do
      allow(user).to receive(:comment_owner?).with(comment).and_return(true)
      expect(subject).to permit(user, comment) 
      admin = create :admin
      expect(subject).to permit(admin, comment)
      other_user = create :user
      expect(subject).to_not permit(other_user, comment)
    end
  end

  permissions :edit? do
    it "grant access" do
      allow(user).to receive(:comment_owner?).with(comment).and_return(true)
      expect(subject).to permit(user, comment) 
    end
  end

  permissions :destroy? do
    it "grant access" do
      allow(user).to receive(:comment_owner?).with(comment).and_return(true)
      expect(subject).to permit(user, comment) 
    end
  end

end