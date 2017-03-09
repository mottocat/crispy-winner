require 'rails_helper'

RSpec.describe ProductUsage, type: :model do

  let(:product_usage) { create :product_usage }

  subject { product_usage }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :product_name }
  it { is_expected.to validate_presence_of :usage_status }
  it { is_expected.to validate_presence_of :comment_body }
  # it { is_expected.to validate_presence_of :images }


end
