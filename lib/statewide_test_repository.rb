require_relative 'statewide_test'

class StatewideTestingRepository
    include DataTranslator

    attr_reader :statewide_tests

    def initialize
      @statewide_tests = Hash.new
    end

    def load_data(data)
      if data.has_key?(:statewide_testing)
      create_repository(data[:statewide_testing])
      end
    end

    def create_repository(data)
      data.each do |data_type, file|
        store_data(data_type, file)
      end
    end

    def store_data(grade_level, file)
      if grade_level == :third_grade || :eighth_grade
        grade_level_data( (load_csv(file)), grade_level )
      elsif
        subject_level_data( load_csv(file), grade_level )
      end
    end

    def grade_level_data(test_data, grade_level)
      test_data.each do |row|
        district_name = district_name(row)
        year = year(row)
        test_type = test_type(row)
        test_average = test_average(row)
        row_data = { :name => district_name, grade_level => {year => {test_type => test_average}}}
        if !@statewide_tests[district_name]
          @statewide_tests[district_name] = StatewideTest.new(row_data)
        else
          @statewide_tests[district_name].add_new_data(row_data)
        end
      end
    end

    def test_type(row)
    row[:score]
  end

  def district_name(row)
    upcase_name(row[:location])
  end

  def year(row)
    row[:timeframe].to_i
  end

  def test_average(row)
    format_number(row[:data])
  end

  def find_by_name(district_name)
    statewide_tests[district_name.upcase]
  end
end
