require_relative 'data_translator'
require_relative 'data_errors'

class StatewideTest
  include DataTranslator
  attr_accessor :name,
                :third_grade,
                :eighth_grade,
                :math,
                :reading,
                :writing

  RACES    =  [:asian, :black, :pacific_islander,
               :hispanic, :native_american, :two_or_more, :white]
  SUBJECTS =  [:math, :reading, :writing]

  def initialize(data)
    @name = upcase_name(data[:name])
    @third_grade = data[:third_grade]
    @eighth_grade = data[:eighth_grade]
    @math = data[:math]
    @reading = data[:reading]
    @writing = data[:writing]
  end

  def store_third_grade(data)
    if @third_grade == nil
      @third_grade = data
    else
      third_grade.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_eighth_grade(data)
    if @eighth_grade == nil
      @eighth_grade = data
    else
      eighth_grade.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_math(data)
    if @math === nil
      @math = data
    else
      math.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_reading(data)
    if reading == nil
      @reading = data
    else
      reading.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_writing(data)
    if writing == nil
      @writing = data
    else
      writing.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def add_new_data(row_data)
    row_data.each_key do |key|
      if key == :third_grade
        store_third_grade(row_data[key])
      elsif key == :eighth_grade
        store_eighth_grade(row_data[key])
      elsif key == :math
        store_math(row_data[key])
      elsif key == :reading
        store_reading(row_data[key])
      elsif key == :writing
        store_writing(row_data[key])
      end
    end
  end

  def proficient_by_grade(grade)
    if grade == 3
      third_grade
    elsif grade == 8
      eighth_grade
    else
      raise UnknownDataError
    end
  end


  def proficient_by_race_or_ethnicity(race)
    if RACES.include?(race)
      race_hash = {}
      extract_race_data_for_math(race, race_hash)
      extract_race_data_for_reading(race, race_hash)
      extract_race_data_for_writing(race, race_hash)
      race_hash
    else
      raise UnknownRaceError
    end
  end

  def extract_race_data_for_math(race, race_hash)
    math.each do |year, race_to_score|
      if race_hash[year].nil?
        race_hash[year] = {math: race_to_score[race]}
      else
        race_hash[year].store(:math, race_to_score[race])
      end
    end
  end

  def extract_race_data_for_reading(race, race_hash)
    reading.each do |year, race_to_score|
      if race_hash[year].nil?
        race_hash[year] = {reading: race_to_score[race]}
      else
        race_hash[year].store(:reading, race_to_score[race])
      end
    end
  end

  def extract_race_data_for_writing(race, race_hash)
    writing.each do |year, race_to_score|
      if race_hash[year].nil?
        race_hash[year] = {writing: race_to_score[race]}
      else
        race_hash[year].store(:writing, race_to_score[race])
      end
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if SUBJECTS.include?(subject)
      data = proficient_by_grade(grade)[year][subject]
      data == 0.0 ? data = "N/A" : data
    else
      raise UnknownDataError
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if RACES.include?(race) && SUBJECTS.include?(subject)
      data = proficient_by_race_or_ethnicity(race)[year][subject]
      format_number(data)
    else
      raise UnknownDataError
    end
  end

end
