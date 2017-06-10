class RekoMap

  def initialize(file)
    @file = file
  end

  def call
    full_text
  end

  private

  attr_reader :file

  def face_details
    reko_response.face_details
  end

  def reko_response
    @reko_response ||= RekognitionFaces.new(file).call
  end

  def face_count
    face_details.size
  end

  def text_messages
    face_details.map.with_index(1){ |face, index| text_message(face, index) }
  end

  def text_message(face, index)
    TextMessage.new(face, index).call
  end

  def intro_text
    "there is #{face_count.humanize} #{person_people} in a front of you"
  end

  def person_people
    return 'person' if face_count == 1
    'people'
  end

  def full_text
    (address + [intro_text] + text_messages )
      .compact
      .map(&:capitalize)
      .join('. ')
  end

  def localization
    @localization ||= EXIFR::JPEG.new(open(file).path).gps
  end

  def address
    ret = []
    if localization.present?
      query = Geocoder.search("#{ localization.latitude },#{ localization.longitude }").first
      ret << "Your position is #{ query.address }"
    end
    ret
  end

end
