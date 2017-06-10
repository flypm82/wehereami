class GenerateLinkToMp3

  def initialize(message_text)
    @message_text = message_text
  end

  def call
    to_mp3_url
  end

  private

  attr_reader :message_text

  def credentials
    Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def polly
    Aws::Polly::Presigner.new(credentials: credentials, region: ENV['AWS_REGION'])
  end

  def to_mp3_url
    polly.synthesize_speech_presigned_url( output_format: 'mp3', text: message_text, voice_id: 'Joanna' )
  end
end
