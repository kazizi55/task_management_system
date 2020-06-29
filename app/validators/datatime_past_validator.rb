class DatatimePastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value == nil
    record.errors[attribute] << "は過去の日時は選択できません" if value < Time.now
  end
end