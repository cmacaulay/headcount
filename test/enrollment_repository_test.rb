require_relative 'test_helper.rb'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :er

  def setup
    @er = EnrollmentRepository.new
  end

  def test_enrollment_repository_exists
    assert_instance_of EnrollmentRepository, @er
    assert_equal EnrollmentRepository, @er.class
  end

  def test_it_can_load_data
    #load_data(data) - takes an argument of the file(s)

  end

#will tak
  def test_it_finds_by_name

  end


  def test_loading_and_finding_enrollments
    skip
    er = EnrollmentRepository.new
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv"
                   }
                 })

    name = "ACADEMY 20"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment.name
    assert enrollment.is_a?(Enrollment)
    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end

  def test_enrollment_repository_with_high_school_data
    skip
      er = EnrollmentRepository.new
      er.load_data({
                     :enrollment => {
                       :kindergarten => "./data/Kindergartners in full-day program.csv",
                       :high_school_graduation => "./data/High school graduation rates.csv"
                     }
                   })
      e = er.find_by_name("MONTROSE COUNTY RE-1J")


      expected = {2010=>0.738, 2011=>0.751, 2012=>0.777, 2013=>0.713, 2014=>0.757}
      expected.each do |k,v|
        assert_in_delta v, e.graduation_rate_by_year[k], 0.005
      end
      assert_in_delta 0.738, e.graduation_rate_in_year(2010), 0.005
    end



end
