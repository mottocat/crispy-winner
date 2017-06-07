Capybara.add_selector(:row) do
  xpath { |num| ".//tbody/tr[#{num}]" }
end

def check_table_row_sorting arr
  arr.each_with_index do |content, index|
    within(:row, index+1) { expect(page).to have_content(content) }
  end
end