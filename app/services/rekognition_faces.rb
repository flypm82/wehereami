class RekognitionFaces
  def initialize(file_url)
    @file_url = file_url
    @client   = Aws::Rekognition::Client.new
  end

  def call
    detect_faces
  end

  private

  attr_reader :file_url, :client

  def detect_faces
    client.detect_faces({
       image: {
         bytes: file
       },
       attributes: ["ALL"]
     })
  end

  def file
    open(file_url)
  end
end
