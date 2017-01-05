# require_relative 'district'
require "csv"
require "pry"

class DistrictRepository

attr_reader :districts

  def initialize
    @districts = {}
  end

  def load_data(data)
    files = data[:enrollment]
    create_repository(files)
  end

  def create_repository(files)
    files.each do |key, file|
      data = load_csv(file)
    # file = CSV.open "#{file}",
    #   headers:true,
    #   header_converters: :symbol
    save_districts(data)
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
      headers:true,
      header_converters: :symbol
  end

  def save_districts(file)
      file.each do |row|
        row[:location].upcase
      end
  end
end
