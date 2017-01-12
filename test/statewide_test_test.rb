require_relative 'test_helper'
require './lib/statewide_test'
require './lib/statewide_test_repository'

class StatewideTestTest < Minitest::Test

  def test_it_stores_name
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    st = StatewideTest.new(row_1)

    expected = "ACADEMY 20"
    assert_equal expected, st.name
  end

  def test_it_stores_data_when_create
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    st = StatewideTest.new(row_1)

    expected = {2008 => {:math => 0.64}}
    assert_equal expected, st.third_grade
  end

  def test_it_stores_data_when_create
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {:reading => 0.4}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)

    expected = {2008 => {:math => 0.64, :reading => 0.4}}
    assert_equal expected, st.third_grade
  end

  def test_it_stores_data_when_create_with_new_year
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {:reading => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :third_grade => {2009 => {:math => 0.09}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)

    expected = {2008 => {:math => 0.64, :reading => 0.4}, 2009 => {:math => 0.09}}
    assert_equal expected, st.third_grade
  end

  def test_it_adds_all_of_the_data
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    row_11 = { :name => "ACADEMY 20", :third_grade => {2009 => {:writing => 0.77}}}
    row_2 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {:reading => 0.4}}}
    row_22 = { :name => "ACADEMY 20", :eighth_grade => {2010 => {:math => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :math => {2009 => {:black => 0.99}}}
    row_33 = { :name => "ACADEMY 20", :math => {2011 => {:asian => 0.77}}}
    row_4 = { :name => "ACADEMY 20", :reading => {2009 => {:white => 0.60}}}
    row_44 = { :name => "ACADEMY 20", :reading => {2015 => {:black => 0.50}}}
    row_5 = { :name => "ACADEMY 20", :writing => {2009 => {:native_american => 0.59}}}
    row_55 = { :name => "ACADEMY 20", :writing => {2010 => {:hispanic => 0.19}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)
    st.add_new_data(row_4)
    st.add_new_data(row_5)
    st.add_new_data(row_11)
    st.add_new_data(row_22)
    st.add_new_data(row_33)
    st.add_new_data(row_44)
    st.add_new_data(row_55)

    third_grade  = {2008=>{:math=>0.64}, 2009=>{:writing=>0.77}}
    eighth_grade = {2008=>{:reading=>0.4}, 2010=>{:math=>0.4}}
    math         = {2009=>{:black=>0.99}, 2011=>{:asian=>0.77}}
    reading      = {2009=>{:white=>0.60}, 2015=>{:black=>0.50}}
    writing      = {2009=>{:native_american=>0.59}, 2010=>{:hispanic=>0.19}}

    assert_equal third_grade, st.third_grade
    assert_equal eighth_grade, st.eighth_grade
    assert_equal math, st.math
    assert_equal reading, st.reading
    assert_equal writing, st.writing
  end


  def test_proficient_by_grade
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {:reading => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :third_grade => {2009 => {:math => 0.09}}}

    row_4 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {:math => 0.88}}}
    row_5 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {:reading => 0.53}}}
    row_6 = { :name => "ACADEMY 20", :eighth_grade => {2009 => {:math => 0.76}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)
    st.add_new_data(row_4)
    st.add_new_data(row_5)
    st.add_new_data(row_6)

    third_grade = {2008=>{:math=>0.64, :reading=>0.4}, 2009=>{:math=>0.09}}
    eighth_grade = {2008=>{:math=>0.88, :reading=>0.53}, 2009=>{:math=>0.76}}
    assert_equal third_grade, st.proficient_by_grade(3)
    assert_equal eighth_grade, st.proficient_by_grade(8)
  end

  def test_it_extracts_proficiency_by_race_or_ethnicity_data1
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
      })
      statewide_test = str.find_by_name("ACADEMY 20")

      expected =  { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
      2012 => {math: 0.818, reading: 0.893, writing: 0.808},
      2013 => {math: 0.805, reading: 0.901, writing: 0.810},
      2014 => {math: 0.800, reading: 0.855, writing: 0.789},
    }

    actual = statewide_test.proficient_by_race_or_ethnicity(:asian)
    assert_equal expected, actual
    assert_in_delta 0.653, statewide_test.proficient_for_subject_by_grade_in_year(:math, 8, 2011), 0.005
  end

  def test_it_extracts_proficiency_by_grade_in_year
      row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {:math => 0.64}}}
      row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {:reading => 0.4}}}
      row_3 = { :name => "ACADEMY 20", :third_grade => {2009 => {:math => 0.09}}}

      row_4 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {:math => 0.88}}}
      row_5 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {:reading => 0.53}}}
      row_6 = { :name => "ACADEMY 20", :eighth_grade => {2009 => {:math => 0.76}}}

      st = StatewideTest.new(row_1)
      st.add_new_data(row_2)
      st.add_new_data(row_3)
      st.add_new_data(row_4)
      st.add_new_data(row_5)
      st.add_new_data(row_6)

      assert_equal 0.09, st.proficient_for_subject_by_grade_in_year(:math, 3, 2009)
      assert_equal 0.53, st.proficient_for_subject_by_grade_in_year(:reading, 8, 2008)
  end

  def test_it_extracts_proficiency_by_race_or_ethnicity_data
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
      })
      statewide_test = str.find_by_name("ACADEMY 20")

    assert_equal 0.818, statewide_test.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
    assert_equal 0.851, statewide_test.proficient_for_subject_by_race_in_year(:reading, :white, 2011)

  end

  def test_proficient_by_grade_raises_error_if_grade_not_3_or_8
    str = StatewideTestRepository.new
    str.load_data({
     :statewide_testing => {
       :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
       :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
       :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
       :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
       :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
     }
   })

   st = str.find_by_name("ACADEMY 20")
  assert_raises(UnknownDataError) {st.proficient_by_grade(4)}
  assert_raises(UnknownDataError) {st.proficient_by_grade(123)}
  assert_raises(UnknownDataError) {st.proficient_by_grade('a')}
end

def test_proficient_by_grade_raises_error_if_invalid_race
  str = StatewideTestRepository.new
  str.load_data({
   :statewide_testing => {
     :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
     :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
     :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
     :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
     :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
   }
 })

  st = str.find_by_name("ACADEMY 20")
  assert_raises(UnknownRaceError) {st.proficient_by_race_or_ethnicity(:chicken)}
  assert_raises(UnknownRaceError) {st.proficient_by_race_or_ethnicity(:caucasian)}
  assert_raises(UnknownRaceError) {st.proficient_by_race_or_ethnicity(:spanish)}
end

def test_proficient_for_subject_grade_year_raises_error_if_wrong_parameter
  str = StatewideTestRepository.new
  str.load_data({
   :statewide_testing => {
     :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
     :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
     :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
     :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
     :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
   }
  })

  st = str.find_by_name("ACADEMY 20")
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_grade_in_year(:science, 3, 2012)}
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_grade_in_year(:geometry, 8, 2941)}
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_grade_in_year(:spanish, 12, 2012)}
end

def test_proficient_for_subject_race_year_raises_error_if_wrong_parameter
  str = StatewideTestRepository.new
  str.load_data({
   :statewide_testing => {
     :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
     :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
     :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
     :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
     :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
   }
   })

  st = str.find_by_name("ACADEMY 20")
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_race_in_year(:math, :yellow, 2012)}
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_race_in_year(:geometry, :spanish, 2941)}
  assert_raises(UnknownDataError) {st.proficient_for_subject_by_race_in_year(:spanish, :white, 2012)}
end
end
