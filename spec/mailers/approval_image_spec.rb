require "rails_helper"

RSpec.describe ApprovalImageMailer, type: :mailer do
  let(:user) { create :user, email: "enes@example.com" }
  let(:product) { create :product }
  let(:approval_image) { create :approval_image, product: product, user: user }
  let(:usage_manifest) { create :usage_manifest, product: product, user: user }


  describe "approved" do


    let(:mail) { ApprovalImageMailer.approved(approval_image) }

    it "renders the headers" do
      expect(mail.subject).to eq("YAY! Your sended image was approved by administration")
      expect(mail.to).to eq(["enes@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("was approved")
    end
  end

  describe "denied" do
    let(:mail) { ApprovalImageMailer.denied(approval_image) }

    it "renders the headers" do
      expect(mail.subject).to eq("Your sended image was denied by administration")
      expect(mail.to).to eq(["enes@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("was denied")
    end
  end

end
