require_relative 'test_helper.rb'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :er

  def setup
    @er = EnrollmentRepository.new
  end

  def test_enrollment_repository_exists
    assert_instance_of EnrollmentRepository, er
    assert_equal EnrollmentRepository, er.class
  end

  def test_it_can_load_data
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"                   }
                 })
  end

  def test_it_can_load_data_and_find_name
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./test/fixtures/High school graduation rates.csv"
                   }
                 })

    name = "ACADEMY 20"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment.name
  end

end
