class District
  attr_reader   :name
  attr_accessor :enrollment,
                :statewide_testing

    def initialize(data)
        @name       = data[:name].upcase
        @enrollment = data[:enrollment]
        @statewide_testing = data[:statewide_testing]
    end

end
