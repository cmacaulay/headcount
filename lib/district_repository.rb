require_relative 'district'
require "csv"
require "pry"

class DistrictRepository

attr_reader :districts

  def initialize
    @districts = Hash.new
  end

  def load_data(data)
    files = data[:enrollment]
    create_repository(files)
  end

  def create_repository(files)
    files.each do |key, file|
      data = load_csv(file)
      save_districts(data)
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
      headers:true,
      header_converters: :symbol
  end

  # def save_districts(file)
  #   @districts = file.collect do |row|
  #       district_name = row[:location].upcase
  #       { district_name => District.new }
  #   end
  # end

  def save_districts(file)
	    file.collect do |row|
        district_name = row[:location].upcase
        binding.pry
		    @districts[district_name] = District.new #will over-write if it finds a duplicate district
	end
end


end
