require 'rails_helper'

RSpec.describe ProductPolicy do
  
  subject { described_class.new(user, record) }

  let(:user) { double }
  let(:record) { double }

  it "#show?" do
    expect(subject.show?).to be_truthy
  end

  it "#new?" do
    expect(subject.new?).to be_truthy
  end

  it "#create?" do
    allow(subject).to receive(:new?).and_return(perm = double)
    expect(subject.create?).to eq perm
  end

  it '#edit?' do
    expect(subject.edit?).to be_falsy
  end

  it "#update?" do
    allow(subject).to receive(:edit?).and_return(perm = double)
    expect(subject.update?).to eq perm
  end

  it "#destroy?" do
    expect(subject.destroy?).to be_falsy
  end

end