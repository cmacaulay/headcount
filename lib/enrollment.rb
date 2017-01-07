require_relative 'enrollment_repository'
require 'pry'

class Enrollment
  attr_reader :name,
              :kindergarten,
              :high_school_graduation

  def initialize(data)
    @name = data[:name].upcase
    @kindergarten = data[:kindergarten_participation]
    @high_school_graduation = data[:high_school_graduation]
    end

    def kindergarten_participation_by_year
     kindergarten
   end

   def kindergarten_participation_in_year(year)
     kindergarten[year]
   end

end
