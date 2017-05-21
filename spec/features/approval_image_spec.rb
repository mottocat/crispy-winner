require "rails_helper"

RSpec.describe "Approval Image", type: :feature do
  
  let!(:user) { create :user }
  let!(:product) { create :product }
  let!(:usage_manifest) { create :usage_manifest, 
    user: user,
    product: product,
    status: :using,
    approved_image: nil }

  before do
    login user
  end

  context "if user has selected as using" do
    it "warns the user for adding an image" do
      visit product_path(product)
      expect(page).to have_content "You must add an photo"
    end
  end

  context "if user has selected as used" do
    it "adding an image for approval isn't necessary" do
      usage_manifest.update!(status: :used)
      visit product_path(product)
      expect(page).to_not have_content "You must add an photo"
    end
  end

  it  "the user adds an image" do
    visit product_path(product)
    attach_file('approval_image_image', 'spec/support/images/products/product1.jpg')
    click_button "Create Approval image"
    expect(page).to have_content("The picture you sended is waiting for approval.")
  end

  describe "when the moderator" do
    let!(:comment) {create :comment, product: product, author: user}

    it "approves the image, the using count increases" do
      visit product_comments_path(product)
      expect(page).to have_content('0 using')
      create :approval_image, user: user, product: product
      visit product_approval_images_path(product)
      click_on "Approve"
      visit product_comments_path(product)
      expect(page).to have_css("#comment_#{comment.id} .bg-green")
      expect(page).to have_content("1 using")
    end

    it "denies the image, the using count is seem same" do
      visit product_comments_path(product)
      expect(page).to have_content('0 using')
      create :approval_image, user: user, product: product
      visit product_approval_images_path(product)
      click_on "Deny"
      visit product_comments_path(product)
      expect(page).to_not have_css("#comment_#{comment.id} .bg-green")
      expect(page).to_not have_css("The picture you sended before denied")
      expect(page).to have_content('0 using') 
    end
  end

end