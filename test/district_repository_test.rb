require './test/test_helper'
require './lib/district_repository'
require './lib/enrollment_repository'

class DistrictRepositoryTest < Minitest::Test

  attr_reader :dr

  def setup
    @dr = DistrictRepository.new
  end

  def load_data
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv",
        :high_school_graduation => "./test/fixtures/High school graduation rates.csv"
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
      assert_equal "ACADEMY 20", district.name

      assert_equal 33, dr.find_all_matching("CO").count
  end

  def test_it_exists
    skip
    assert_instance_of DistrictRepository, @dr
  end

  def test_new_hash_is_initialized
    skip
    assert_equal Hash, @dr.districts.class
  end

  def test_it_loads_file_and_will_find_by_name
    skip
    assert dr.districts.empty?
    load_data
    refute dr.districts.empty?
    assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20").name
  end

  def test_it_will_find_all_matching
    assert dr.districts.empty?
    load_data
    refute dr.districts.empty?
    expected = ["COLORADO", "ADAMS COUNTY 14", "ARCHULETA COUNTY 50 JT", "CHEYENNE COUNTY RE-5", "COLORADO SPRINGS 11", "COTOPAXI RE-3", "CREEDE CONSOLIDATED 1", "CROWLEY COUNTY RE-1-J", "CUSTER COUNTY SCHOOL DISTRICT C-1", "DELTA COUNTY 50(J)", "DENVER COUNTY 1", "DOLORES COUNTY RE NO.2", "DOUGLAS COUNTY RE 1", "EAGLE COUNTY RE 50", "EAST YUMA COUNTY RJ-2", "ELLICOTT 22", "FALCON 49", "GILPIN COUNTY RE-1", "HINSDALE COUNTY RE 1", "JEFFERSON COUNTY R-1", "LAKE COUNTY R-1", "MANCOS RE-6", "MESA COUNTY VALLEY 51", "MOFFAT COUNTY RE:NO 1", "MONTEZUMA-CORTEZ RE-1", "MONTROSE COUNTY RE-1J", "NORTH CONEJOS RE-1J", "PARK COUNTY RE-2", "PUEBLO COUNTY RURAL 70", "SOUTH CONEJOS RE-10", "WELD COUNTY RE-1", "WELD COUNTY S/D RE-8", "WEST YUMA COUNTY RJ-1"]
    assert_equal "COLORADO", @dr.find_by_name("COLORADO").name
    assert_equal expected, @dr.find_all_matching("co")

    assert_equal "COLORADO", @dr.find_by_name("COLORADO").name
    assert_equal expected, @dr.find_all_matching("co")
  end

  def test_district_repo
      dr = DistrictRepository.new
      load_data
    end
end
