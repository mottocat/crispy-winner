require 'rails_helper'

RSpec.describe Product, type: :model do

  subject { create :product }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :brand }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :brand }

  it { is_expected.to have_many :comments }
end
