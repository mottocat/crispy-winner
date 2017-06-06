require 'rails_helper'

RSpec.describe DashboardPolicy do
  subject { described_class }

  let(:user) { create :user }
  let(:admin) { create :admin }

  permissions :index? do
    it "grant access" do
      expect(subject).to_not permit(user, :dasboard) 
      expect(subject).to permit(admin, :dasboard) 
    end
  end

end