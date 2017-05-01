require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class.new(user, record) }

  let(:user) { double }
  let(:product) { double }
  let(:record) { double product: product }

  it "#new?" do
    allow(subject).to receive(:create?).and_return(perm = double)
    expect(subject.new?).to eq perm 
  end

  it "#create?" do
    allow(user).to receive(:has_comment_on?).and_return(false)
    expect(subject.create?).to eq true
  end

  it "#update?" do
    allow(user).to receive(:comment_owner?).with(record).and_return(true)
    expect(subject.update?).to be true
  end

  it '#edit?' do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.edit?).to eq perm
  end

  it "#destroy?" do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.destroy?).to eq perm
  end

end