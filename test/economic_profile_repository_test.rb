require './test/test_helper'
require './lib/economic_profile_repository'

class EconomicProfileRepositoryTest < Minitest::Test

  def test_class_exists
    epr = EconomicProfileRepository.new

    assert_instance_of EconomicProfileRepository, epr
  end

  def test_it_loads_data
    epr = EconomicProfileRepository.new
    epr.load_data({
  :economic_profile => {
    :median_household_income => "./data/Median household income.csv",
    :children_in_poverty => "./data/School-aged children in poverty.csv",
    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
    :title_i => "./data/Title I students.csv"
    }
  })
  end

end
