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
      }
      })
      district = dr.find_by_name("ACADEMY 20")
      assert_equal "ACADEMY 20", district.name

      assert_equal 2, dr.find_all_matching("CO").count
    end

  def test_it_exists
    assert_instance_of DistrictRepository, @dr
  end

  def test_new_hash_is_initialized
    assert_equal Hash, @dr.districts.class
  end

  def test_it_loads_file_and_will_find_by_name
    assert dr.districts.empty?
    load_data
    refute dr.districts.empty?
    assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20").name
  end

  def test_it_will_find_all_matching
    assert dr.districts.empty?
    load_data
    refute dr.districts.empty?

    assert_equal "COLORADO", @dr.find_by_name("COLORADO").name
    assert_equal ["COLORADO", "ADAMS COUNTY 14"], @dr.find_all_matching("co")
    binding.pry
  end

end
