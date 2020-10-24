# frozen_string_literal: true

# Validator for the incoming requests
module InputValidators
  def self.chek_date_description(raw_date, raw_description)
    # Strict value
    date = raw_date || ''
    description = raw_description || ''
    errors = []
    errors.concat(chek_date_format(date)) unless date.empty?
    {
      date: date,
      description: description,
      errors: errors
    }
  end

  # Filter categories
  def self.chek_date_format(date)
    unless /\d(4)-\d(2)-\d(2)/ =~ date
      ['Дата должна быть передана в формате ГГГГ-ММ-ДД']
    else
      []
    end
  end
end
