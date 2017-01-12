require_relative 'test_helper.rb'
require './lib/district'
require './lib/district_repository'
require 'pry'

class DistrictTest < Minitest::Test

  def test_name_returns_upcased_string
    d = District.new({:name => "Colorado"})

    assert_equal "COLORADO", d.name
  end

  def test_district_repo_is_not_nil_after_data_is_loaded
    dr = DistrictRepository.new

    dr.load_data({
                    :enrollment => {
                      :kindergarten => "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv"
                                    }
                  })

    assert "COLORADO", dr.find_by_name("COLORADO")
    assert "ACADEMY 20", dr.find_by_name("ACADEMY 20")

  end

  def test_relationship_between_district_and_enrollment
    dr = DistrictRepository.new

    dr.load_data({
                    :enrollment => {
                      :kindergarten => "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv"
                                    }
                  })

    district = dr.find_by_name("ACADEMY 20")

    assert_instance_of District, district
    assert_equal "ACADEMY 20", district.enrollment.name
  end

  def test_relationship_between_district_and_statewidetest
    dr = DistrictRepository.new

    dr.load_data({
                    :enrollment => {
                      :kindergarten => "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv",
                                    },
                    :statewide_testing => {
                      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                                           }
                  })

    district = dr.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", district.statewide_test.name
  end

  def test_relationship_between_district_and_economic_profile
    dr = DistrictRepository.new

    dr.load_data({
                  :enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                                  },
                  :statewide_testing => {
                    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                    :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                    :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                    :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                                         },
                  :economic_profile => {
                    :median_household_income => "./data/Median household income.csv",
                    :children_in_poverty => "./data/School-aged children in poverty.csv",
                    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                    :title_i => "./data/Title I students.csv"
                                        }
                  })

      district = dr.find_by_name("ACADEMY 20")

      assert_equal "ACADEMY 20", district.economic_profile.name
  end
end
