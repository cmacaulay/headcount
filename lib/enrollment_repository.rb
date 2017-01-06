require 'csv'
require_relative 'enrollment'

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = Hash.new
  end


  def load_data(data)
    create_repository(files(data))
  end

  def files(data)
    data[:enrollment]
  end

  def create_repository(files)
    files.each do |key, file|
      if files.has_key?(key)
        binding.pry
        save_enrollment_data(key, load_csv(file))
    end
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
      headers:true,
      header_converters: :symbol
  end

  def save_enrollment_data(key, file)
	    something = file.collect do |row|
        year = row[:timeframe]
        enrollment_percentage = row[:data]
        hash = { key.row => create_hash(row)}
        binding.pry
        # hash_with_key[year] = enrollment_percentage
        # enrollments[district_name(row)] = Enrollment.new({:name => district_name(row), key => row }) #will over-write if it finds a duplicate district
	  end
  end

  def create_hash(row)
    
  end


  def district_name(row)
    row[:location].upcase
  end


  def find_by_name(name)

  end

end
