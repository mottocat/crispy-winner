require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create :user }
  let(:product) { create :product }
  subject { user }

  it { is_expected.to have_attribute :first_name }
  it { is_expected.to have_attribute :last_name }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }

  it { is_expected.to have_many :usage_manifests }
  it { is_expected.to have_many :products }
  it { is_expected.to have_many(:comments).with_foreign_key('author_id') }

  it "#full_name" do
    user.update first_name: "Firstname", last_name: "Lastname"
    expect(subject.full_name).to eq("Firstname Lastname")
  end

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

  it "#has_comment_on?" do
    allow(user).to receive_message_chain(:comments, :find_by).
                      with(product: product).
                      and_return(true)
    expect(user.has_comment_on? product).to be true
  end

  it "#comment_owner?" do
    comment = double author: user
    expect(user.comment_owner? comment).to be true
  end

end
