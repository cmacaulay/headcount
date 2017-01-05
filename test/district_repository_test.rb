require './test/test_helper'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  attr_reader :dr

  def setup
    @dr = DistrictRepository.new
  end

  def load_data
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
      })
      # district = dr.find_by_name("ACADEMY 20")

      # assert_equal "ACADEMY 20", district.name

      # assert_equal 7, dr.find_all_matching("WE").count
    end

  def test_it_exists
    assert_instance_of DistrictRepository, @dr
  end

  def test_new_hash_is_initialized
    assert_equal Hash.new, @dr.districts
  end

  def test_it_loads_file
    assert dr.districts.empty?
    load_data
    assert dr.districts.empty?
  end

  def test_it_can_find_by_name
    assert_equal nil, dr.find_by_name("french_fries")
    assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20")
  end

end
