require_relative 'data_translator'

class StatewideTest
  include DataTranslator
  attr_accessor :name,
                :third_grade,
                :eighth_grade,
                :math,
                :reading,
                :writing

  def initialize(data)
    @name = upcase_name(data[:name])
    @third_grade = data[:third_grade]
    @eighth_grade = data[:eighth_grade]
    @math = data[:math]
    @reading = data[:reading]
    @writing = data[:writing]
  end

  def add_new_data(row_data)
      if row_data.has_key?(:third_grade)
        data = row_data[:third_grade]
        third_grade.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      elsif eighth_grade == nil
        @eighth_grade = row_data[:eighth_grade]
      elsif
        data = row_data[:eighth_grade]
        eighth_grade.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      elsif math == nil
        @math = row_data[:math]
      elsif row_data.has_key?(:math)
        data = row_data[:math]
        math.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      elsif reading == nil
        @reading = row_data[:reading]
      elsif row_data.has_key?(:reading)
        data = row_data[:reading]
        reading.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      elsif writing == nil
        @writing = row_data[:writing]
      else row_data.has_key?(:writing)
        data = row_data[:writing]
        writing.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      end
  end

  def proficient_by_grade(grade)
    if grade == 3
      third_grade
    else grade == 8
      eighth_grade
    end
  end

end
