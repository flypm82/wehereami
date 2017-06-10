class TextMessage

  def initialize(face, index)
    @face_object = FaceObject.new(face)
    @index       = index
  end

  def call
    full_text
  end

  attr_reader :face_object, :index

  private

  def intro
    "person #{index.humanize}"
  end

  def gender
    face_object.gender
  end

  def asimuth
    "at your #{face_object.asimuth} o’clock position" if face_object.asimuth
  end

  def age
    "in the age between #{face_object.age[:low]}  and #{face_object.age[:high]}" if face_object.age
  end

  def emotions
    "appears to be #{face_object.emotions}" if face_object.emotions
  end

  def full_text
    [intro, gender, asimuth, age, emotions].compact.join(', ')
  end

end
