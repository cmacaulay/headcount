require 'csv'
require_relative 'enrollment'

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = Hash.new
  end


  def load_data(data)
    files = data[:enrollment]
    create_repository(files)
  end

  def create_repository(files)
    files.each do |key, file|
      data = load_csv(file)
      save_enrollment_data(key, data)
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
      headers:true,
      header_converters: :symbol
  end

  def save_enrollment_data(key, file)
	    file.collect do |row|
        enrollments[district_name(row)] = Enrollment.new({:name => district_name(row), key => row }) #will over-write if it finds a duplicate district
	  end
  end
  #
  def district_name(row)
    row[:location].upcase
  end


  def find_by_name(name)

  end

end
