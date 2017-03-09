module ApplicationHelper
  def humanize_status_for status
    {
      using: 'I am using this product now',
      used: 'I used this product before'
    }[status.to_sym]
  end
end
