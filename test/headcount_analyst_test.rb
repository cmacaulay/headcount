require_relative 'test_helper.rb'
require "./lib/headcount_analyst"
require "./lib/district_repository"
require 'pry'



class HeadcountAnalystTest < Minitest::Test

  def test_it_exists
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"}})
    ha = HeadcountAnalyst.new(dr)
    assert_instance_of HeadcountAnalyst, ha
  end

  def test_kindergarten_participation_rate_variation_works
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"}})
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1.357, ha.kindergarten_participation_rate_variation("ACADEMY 20", :against => "ADAMS COUNTY 14")
    assert_equal 0.766, ha.kindergarten_participation_rate_variation("ACADEMY 20", :against => "COLORADO")
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"}})
    ha = HeadcountAnalyst.new(dr)
    expected =
    #  {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
     {2004=>0.066, 2005=>0.118, 2006=>0.092, 2007=>0.167, 2008=>0.22, 2009=>0.167, 2010=>0.245, 2011=>0.369, 2012=>0.329, 2013=>0.0, 2014=>0.375}
    assert_equal expected, ha.kindergarten_participation_rate_variation_trend('BOULDER VALLEY RE 2', :against => 'COLORADO')
  end

  def test_kindergarten_participation_against_high_school_graduation
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {
      :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv",
      :high_school_graduation => "./test/fixtures/High school graduation rates.csv"
      }})
    ha = HeadcountAnalyst.new(dr)

    assert_equal 1.357, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')

    assert_equal 0.766, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    # assert_equal 0.548, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    # assert_equal 0.800, ha.kindergarten_participation_against_high_school_graduation('ADAMS COUNTY 14')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {
      :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv",
      :high_school_graduation => "./test/fixtures/High school graduation rates.csv"
      }})
    ha = HeadcountAnalyst.new(dr)

    assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
  end



end
