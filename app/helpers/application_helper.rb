module ApplicationHelper
  def humanize_status_for status
    {
      using: 'I am using this product now',
      used: 'I used this product before'
    }[status.to_sym]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    sorted_by = column == sort_column ? "(#{sort_direction})" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"

    link_to({sort: column, direction: direction}, { class: "link blue" }) do
      "#{title} #{sorted_by}"
    end
  end
end
