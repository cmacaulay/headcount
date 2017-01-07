require_relative 'district'
require "csv"
require "pry"

class DistrictRepository

attr_reader :districts
            :enrollment_repository

  def initialize
    @districts               = Hash.new
    @enrollment_repository   = EnrollmentRepository.new
  end

  def load_data(data)
    files = data[:enrollment]
    create_repository(files)
    # binding.pry
    @enrollment_repository.load_data(data)
    binding.pry
  end

  def create_repository(files)
    files.each do |key, file|
      data = load_csv(file)
      save_districts(key, data)
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
      headers:true,
      header_converters: :symbol
  end

  def save_districts(key, file)
	    file.collect do |row|
        districts[district_name(row)] = District.new({:name => district_name(row)}) #will over-write if it finds a duplicate district
    end
  end

  def district_name(row)
    row[:location].upcase
  end

  def find_by_name(name)
    if districts.has_key?(name.upcase) == true
      districts[name.upcase]
      # else ERROR this isn't a real district
    end
  end

  def find_all_matching(name_fragment)
    matches = districts.select do |district|
      district.include?(name_fragment.upcase)
    end
    matches.keys
  end

end
