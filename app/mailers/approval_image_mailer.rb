class ApprovalImageMailer < ApplicationMailer

  def approved approval_image
    @approval_image = approval_image

    mail to: approval_image.user.email,
          subject: "YAY! Your sended image was approved by administration" 
  end

  def denied approval_image
    @approval_image = approval_image

    mail to: approval_image.user.email,
          subject: "Your sended image was denied by administration" 
  end
end
