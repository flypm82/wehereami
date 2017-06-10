class ReportMailer < ApplicationMailer

  def email(params)
    puts params
    @text = params[:text]
    @link = params[:link]

    mail(subject: "Your picture present", reply_to: Rails.application.secrets.default_email,
         from: "\WhoAmI - Hackathon Travel To The Cloud\ <#{ Rails.application.secrets.default_email }>", to: params[:email])
  end

end
