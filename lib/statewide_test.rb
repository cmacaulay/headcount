require_relative 'data_translator'

class StatewideTest
  include DataTranslator

  attr_accessor :name, :third_grade, :eighth_grade
  # attr_accessor :name


  def initialize(data)
    @name = upcase_name(data[:name])
    @third_grade = data[:third_grade]
    @eighth_grade = data[:eighth_grade]

    # @third_grade = data[:third_grade] # {2008 => {"Math" => 0.64, "Writing" => 2, "Reading" => 3}, 2009 => {}}
    # @math = data[:math]
    # @reading = data[:reading]
    # @writing = data[:writing]
  end

  def add_new_data(row_data)
      if row_data.has_key?(:third_grade)
        data = row_data[:third_grade]
        third_grade.merge!(data) do |year, original, addition|
          original.merge(addition)
        end
      elsif eighth_grade == nil
        @eighth_grade = row_data[:eighth_grade]
      else
        data = row_data[:eighth_grade]
        eighth_grade.merge!(data) do |year, original, addition|
          original.merge(addition)
      end
    end
     #<-
    #how do I know what kind of data this is? Maybe need to pass in another arg that tells me?
    # save the things
  end


end
