require_relative 'test_helper'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def test_enrollment_basics
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    all_years = {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}
    assert_in_delta 0.391, e.kindergarten_participation_in_year(2010), 0.005
    assert_in_delta 0.267, e.kindergarten_participation_in_year(2012), 0.005

    truncated = all_years.map { |year, rate| [year, rate.to_s[0..4].to_f]}.to_h
    truncated.each do |k,v|
      assert_in_delta v, e.kindergarten_participation_by_year[k], 0.005
    end
  end

  def test_enrollment_highschool_grad_methods
    e = Enrollment.new({:name => "COLORADO", :kindergarten_participation => {2007=>"0.39465",
   2006=>"0.33677",
   2005=>"0.27807",
   2004=>"0.24014",
   2008=>"0.5357",
   2009=>"0.598",
   2010=>"0.64019",
   2011=>"0.672",
   2012=>"0.695",
   2013=>"0.70263",
   2014=>"0.74118"},
   :high_school_graduation => {2010=>"0.724", 2011=>"0.739", 2012=>"0.75354", 2013=>"0.769", 2014=>"0.773"} } )
   all_years = {2010=>"0.724", 2011=>"0.739", 2012=>"0.75354", 2013=>"0.769", 2014=>"0.773"}

   assert_equal all_years, e.graduation_participation_by_year
   assert_equal "0.724", e.graduation_rate_in_year(2010)
  end


end
