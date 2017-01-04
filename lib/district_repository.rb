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
    load_csv(files)
  end

  def load_csv(files)
    files.each do |key, value|
    file = CSV.open "#{value}", headers:true, header_converters: :symbol
    save_districts(file)
    end
  end

  def save_districts(file)
    @districts =
      file.map do |row|
        row[:location].upcase
      end
  end
end
