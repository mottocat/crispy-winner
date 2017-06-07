require "rails_helper"

module Administration
  RSpec.describe "Comments", type: :feature do
    
    let!(:admin) { create :admin }
    let(:user1) { create :user, first_name: "Ali" }
    let(:user2) { create :user, first_name: "Veli" }
    let(:product1) { create :product, brand: "ABC" }
    let(:product2) { create :product, brand: "DEF" }
    let!(:comment1) { 
      create :comment,
              product: product1,
              author: user1,
              created_at: 1.day.ago,
              body: "Comment#1"
    }

    let!(:comment2) {
      create :comment,
              product: product2,
              author: user2,
              created_at: 2.days.ago,
              body: "Comment#2"
    }

    before do
      login admin

      visit administration_path
      click_link "COMMENTS (2)"
    end

    it "get products" do
      expect(page).to have_content("COMMENTS (2)")
      expect(page).to have_css("tbody tr", count: 2)
    end

    it "sorts default by created_at" do
      check_table_row_sorting %w(Comment#2 Comment#1)
      click_link "Created At"
      check_table_row_sorting %w(Comment#1 Comment#2)
    end

    it "sorts by product" do
      within "th:first-child" do
        click_link "Product"
      end
      check_table_row_sorting %w(ABC DEF)

      within "th:first-child" do
        click_link "Product"
      end
      check_table_row_sorting %w(DEF ABC)
    end

    it "sorts by author" do
      click_link "Author"
      check_table_row_sorting %w(Ali Veli)

      click_link "Author"
      check_table_row_sorting %w(Veli Ali)
    end

  end
end