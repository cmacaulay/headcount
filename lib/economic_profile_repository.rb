require_relative 'economic_profile'
require_relative 'data_translator'

class EconomicProfileRepository
  include DataTranslator
  attr_reader :economic_profiles

  def initialzie
    @economic_profiles = Hash.new
  end

  def load_data(data)
    if data.has_key?(:economic_profile)
    create_repository(data[:economic_profile])
    end
  end

  def create_repository(data)
    data.each do |data_type, file|
      binding.pry
    end
  end
end
