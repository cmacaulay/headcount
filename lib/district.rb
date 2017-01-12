class District
  attr_reader   :name
  attr_accessor :enrollment,
<<<<<<< HEAD
                :statewide_test
=======
                :statewide_testing,
                :economic_profile
>>>>>>> f30e2e9809b15861c4030f7f7cb886c3024a5df1

    def initialize(data)
        @name       = data[:name].upcase
        @enrollment = data[:enrollment]
<<<<<<< HEAD
        @statewide_test = data[:statewide_testing]
=======
        @statewide_testing = data[:statewide_testing]
        @economic_profile  = data[:economic_profile]
>>>>>>> f30e2e9809b15861c4030f7f7cb886c3024a5df1
    end

end
