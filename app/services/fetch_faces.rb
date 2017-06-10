class FetchFaces

  def initialize(message_id)
    @message_id = message_id
  end

  def call
    fetch_faces
  end

  # private

  attr_reader :message_id

  def message
    @message ||= DownloadAttachments.new(message_id).call
  end

  def fetch_faces
    {
      link: GenerateLinkToMp3.new(reko_map(file)).call,
      text: reko_map(file),
      email: email
    } if message
  end

  def file
    message.fetch(:files, []).first
  end

  def reko_map(file)
    @reko_map ||= RekoMap.new(file).call
  end

  def reko_faces(file)
    RekognitionFaces.new(file).call
  end

  def email
    message[:email]
  end

end
