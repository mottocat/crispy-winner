require "rails_helper"

RSpec.describe "Comment", type: :feature do
  let!(:product) { create :product }

  it "can added by signed user", js: true do
    user = create :user
    login user
    visit product_comments_path(product)
    expect {
      within "form#new_comment" do
        fill_in "comment_body",
          with: "My comment is about that you have never seen before." 
        click_button "Save"
      end 
      all("a")
    }.to change { product.comments.count }.by(1)
  end

  it "can't added by anonymous user" do
    user = create :user
    create :comment, product: product, author: user 
    login user
    visit product_comments_path(product)
    expect(page).to_not have_css("#comment_body")
  end

  it "can removed by comment owner", js: true do
    user = create :user
    create :comment, body: "This comment is going to removed.",
      product: product, author: user 
    login user
    visit product_comments_path(product)

    expect(page).to have_content("This comment is going to removed.")

    handle_js_confirm do
      within "div#new_comment" do
        click_link "×"
      end
    end

    expect(page).to_not have_content("This comment is going to removed.")
  end

  it "can edited by comment owner", js: true do
    user = create :user
    create :comment, body: "This comment is going to edited.",
      product: product, author: user 
    login user
    visit product_comments_path(product)

    within "form#new_comment" do
      click_link "[edit]"
    end

    fill_in "comment_body", with: "This comment is edited by owner"
    within ".edit_comment" do
      click_button "Save"
    end

    visit product_comments_path(product)
    expect(page).to_not have_content("This comment is going to edited")
    expect(page).to have_content("This comment is edited by owner")
  end


end
