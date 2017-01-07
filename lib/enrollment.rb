require_relative 'enrollment_repository'
require 'pry'

class Enrollment
  attr_reader :name,
              :kindergarten,
              :high_school_graduation

  def initialize(data)
    @name = data[:name].upcase
    @kindergarten = data[:kindergarten]
    @high_school_graduation = data[:high_school_graduation_rates]
    end

end
