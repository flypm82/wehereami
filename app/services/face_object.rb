class FaceObject
  attr_reader :face

  def initialize(face)
    @face = face
  end

  def gender
    face.gender.value if face.gender.confidence > 50
  end

  def age
    {
      low:  face.age_range.low,
      high: face.age_range.high
    } if face.age_range.present?
  end

  def emotions
    emo = face.emotions.max_by(&:confidence)
    if emo.present? && emo.confidence > 35
      emo.type
    end
  end

  def nose
    face.landmarks.map(&:to_hash).find{ |h| h[:type] == 'nose'}
  end

  def asimuth
    x = nose.fetch(:x, nil)
    case x
    when  0..(0.0625)
      10
    when  (0.0625)..(0.1875)
      10.30
    when  (0.1875)..(0.3125)
      11
    when  (0.3125)..(0.4375)
      11.30
    when  (0.4375)..(0.5625)
      12
    when  (0.5625)..(0.6875)
      12.30
    when  (0.6875)..(0.8125)
      1
    when  (0.8125)..(0.9375)
      1.30
    when  (0.9375)..1
      2
    else nil
    end
  end
end
