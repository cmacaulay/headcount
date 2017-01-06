require_relative 'enrollment_repository'
require 'pry'

class Enrollment
  attr_reader :name,
              :kindergarten_participation,
              :high_school_graduation

  def initialize(args)
    @name = data[:name].upcase
    @kindergarten_participation =
      data[:kindergarten_participation]
    @high_school_graduation =
      data[:high_school_graduation]
  end

end
