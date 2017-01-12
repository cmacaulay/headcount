require_relative 'economic_profile'
require_relative 'data_translator'

class EconomicProfileRepository
  include DataTranslator
  attr_reader :economic_profiles

  def initialize
    @economic_profiles = Hash.new
  end

  def load_data(data)
    if data.has_key?(:economic_profile)
    create_repository(data[:economic_profile])
    end
  end

  def create_repository(data)
    data.each do |economic_indicator, file|
    if economic_indicator == :median_household_income
      load_income_data(load_csv(file), economic_indicator)
    elsif economic_indicator == :children_in_poverty || economic_indicator == :title_i
      load_poverty_data(load_csv(file), economic_indicator)
    else
      load_lunch_data(load_csv(file), economic_indicator)
    end
    end
  end

  def load_income_data(economic_data, economic_indicator)
    economic_data.each do |row|
      district_name = row[:location]
      income        = row[:data].to_i
      years = row[:timeframe].split("-").map { |num| num.to_i }
      row_data = { :name => district_name, economic_indicator => {years => income }}
        if !@economic_profiles[district_name]
          @economic_profiles[district_name] = EconomicProfile.new(row_data)
        else
          @economic_profiles[district_name].add_new_data(row_data)
        end
    end
  end

  def load_poverty_data(economic_data, economic_indicator)
    economic_data.each do |row|
      if row[:dataformat] == "Percent"
      district_name = row[:location]
      rate          = determine_rate(row)
      year = row[:timeframe].to_i
      row_data = { :name => district_name, economic_indicator => {year => rate }}
        if !@economic_profiles[district_name]
          @economic_profiles[district_name] = EconomicProfile.new(row_data)
        else
          @economic_profiles[district_name].add_new_data(row_data)
        end
      end
    end
  end

  def load_lunch_data(economic_data, economic_indicator)
    economic_data.each do |row|
      if row[:poverty_level] == "Eligible for Free or Reduced Lunch"
      district_name = upcase_name(row[:location])
      year = row[:timeframe].to_i
      rate          = determine_rate(row)
      data_type = determine_data_type(row)
      row_data = { :name => district_name, economic_indicator => {year => {data_type => rate } } }
        if !@economic_profiles[district_name]
          @economic_profiles[district_name] = EconomicProfile.new(row_data)
        else
          @economic_profiles[district_name].add_new_data(row_data)
        end
      end
    end
  end

  def determine_data_type(row)
    if row[:dataformat] == "Percent"
      :percentage
    else
      :total
    end
  end

  def determine_rate(row)
    format_number(row[:data])
  end

  def find_by_name(name)
    economic_profiles[name.upcase]
  end
end
