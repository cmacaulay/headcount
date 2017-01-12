require_relative 'test_helper'
require './lib/statewide_test_repository'

class StatewideTestRepositoryTest < Minitest::Test

  def test_it_exists
    str = StatewideTestRepository.new
    assert_equal StatewideTestRepository, str.class
    assert_instance_of StatewideTestRepository, str
  end

  def test_it_loads_data
    str = StatewideTestRepository.new

    assert_instance_of Hash, str.statewide_tests
    assert str.statewide_tests.empty?

    str.load_data({
    :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
      }
      })
  refute str.statewide_tests.empty?
  end

  def test_it_finds_by_name_and_can_pull_specific_data
    str = StatewideTestRepository.new

    assert str.statewide_tests.empty?
    str.load_data({
    :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    }
    })

    assert_instance_of StatewideTest, str.find_by_name("ACADEMY 20")
    expected = {:math=>0.857, :reading=>0.866, :writing=>0.671}
    academy_20_data = str.find_by_name("ACADEMY 20")
    assert_equal expected, academy_20_data.third_grade[2008]
  end

  def test_it_can_load_all_of_the_data
    str = StatewideTestRepository.new

    assert str.statewide_tests.empty?
    str.load_data({
    :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
    :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
    :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
    }
    })
    academy_20_data = str.find_by_name("ACADEMY 20")

    refute academy_20_data.math.empty?
    refute academy_20_data.reading.empty?
    refute academy_20_data.writing.empty?
    refute academy_20_data.third_grade.empty?
    refute academy_20_data.eighth_grade.empty?


  end

end
