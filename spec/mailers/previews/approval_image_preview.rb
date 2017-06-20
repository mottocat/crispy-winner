# Preview all emails at http://localhost:3000/rails/mailers/approval_image
class ApprovalImagePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/approval_image/approved
  def approved
    ApprovalImageMailer.approved
  end

  # Preview this email at http://localhost:3000/rails/mailers/approval_image/denied
  def denied
    ApprovalImageMailer.denied
  end

end
