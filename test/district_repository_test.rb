require './test/test_helper'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
  end

  def test_it_exists
    assert_instance_of DistrictRepository, @dr
  end

  def test_it_can_find_by_name
    skip
    assert_equal nil, dr.find_by_name("french_fries")
    assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20")
  end

  def test_loading_and_finding_districts
      dr = DistrictRepository.new
      dr.load_data({
                     :enrollment => {
                       :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
                     }
                   })
      # district = dr.find_by_name("ACADEMY 20")

      # assert_equal "ACADEMY 20", district.name

      # assert_equal 7, dr.find_all_matching("WE").count
  end

end
