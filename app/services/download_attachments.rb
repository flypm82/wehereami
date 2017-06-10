require 'contextio'

class DownloadAttachments

  def initialize message_id
    @message_id = message_id
  end

  def call
    if files.present?
      {
          email: from_email,
          files: files
      }
    else
      {}
    end
  end

  private

  attr_reader :message_id

  def contextio
    ContextIO.new(Rails.application.secrets.context_to_api_key, Rails.application.secrets.context_to_api_secret)
  end

  def account
    contextio.accounts[Rails.application.secrets.context_to_api_account_id]
  end

  def message
    @message ||= account.messages[message_id]
  end

  def files
    @files ||= message.files.each_with_object([]) do |file, array|
      array << file.content_link
    end
  end

  def from_email
    message.from['email']
  end

end
