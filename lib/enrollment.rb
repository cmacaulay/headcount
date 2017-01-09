require_relative 'data_translator'

class Enrollment
  include DataTranslator

  attr_reader :name,
              :kindergarten,
              :high_school_graduation

  def initialize(data)
    @name = upcase_name(data[:name])
    @kindergarten = data[:kindergarten_participation]
    @high_school_graduation = data[:high_school_graduation]
  end

  def kindergarten_participation_by_year
     kindergarten
  end

  def kindergarten_participation_in_year(year)
    kindergarten[year]
  end

  def graduation_participation_by_year
   high_school_graduation
  end

 def graduation_rate_in_year(year)
   high_school_graduation[year]
 end

end
