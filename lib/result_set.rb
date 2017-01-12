require_relative 'result_entry'
require_relative 'headcount_analyst'

class ResultSet
  attr_reader :matching_districts,
              :statewide_average

  def initialize(data)
    @matching_districts = data[:matching_districts]
    @statewide_average  = data[:statewide_average]
  end


end
