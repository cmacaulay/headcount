require_relative 'test_helper.rb'
require "./lib/headcount_analyst"
require "./lib/district_repository"



class HeadcountAnalystTest < Minitest::Test

  def test_it_exists
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"}})
    hca = HeadcountAnalyst.new(dr)
    assert_instance_of HeadcountAnalyst, hca
  end

  def test_kindergarten_participation_rate_variation_works
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"}})
    hca = HeadcountAnalyst.new(dr)
    assert_equal 1.353, hca.kindergarten_participation_rate_variation("ACADEMY 20", :against => "ADAMS COUNTY 14")
    assert_equal 0.766, hca.kindergarten_participation_rate_variation("ACADEMY 20", :against => "COLORADO")
  end

  # def test_enrollment_analysis_basics
  #   dr = DistrictRepository.new
  #   dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
  #   ha = HeadcountAnalyst.new(dr)
  #   assert_in_delta 1.126, ha.kindergarten_participation_rate_variation("GUNNISON WATERSHED RE1J", :against => "TELLURIDE R-1"), 0.005
  #   assert_in_delta 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1'), 0.005
  # end
end
