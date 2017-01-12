require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'data_translator'
require_relative 'statewide_test_repository'
require_relative 'economic_profile_repository'

class DistrictRepository
  include DataTranslator

attr_reader :districts,
            :enrollment_repository,
            :statewide_testing_repository

  def initialize
    @districts               = Hash.new
    @enrollment_repository   = EnrollmentRepository.new
    @statewide_testing_repository = StatewideTestRepository.new
    @economic_profile_repository = EconomicProfileRepository.new
  end

  def load_data(data)
    @enrollment_repository.load_data(data)
    @statewide_testing_repository.load_data(data)
    @economic_profile_repository.load_data(data)
    data.each_key do |key|
      create_repository(data[key])
    end
  end

  def create_repository(files)
    files.each do |key, file|
      data = load_csv(file)
      save_districts(key, data)
    end
  end

  def save_districts(key, file)
    file.collect do |row|
      districts[district_name(row)] = District.new({:name => district_name(row),
        :enrollment => @enrollment_repository.find_by_name(district_name(row)),
        :statewide_testing => @statewide_testing_repository.find_by_name(district_name(row)),
        :economic_profile => @economic_profile_repository.find_by_name(district_name(row))})
    end
  end

  def district_name(row)
    upcase_name(row[:location])
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
