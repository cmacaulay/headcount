require './test/test_helper'
require 'pry'
require './lib/economic_profile'

class EconomicProfileTest < Minitest::Test

  def test_it_exists
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)

    assert_equal EconomicProfile, economic_profile.class
    assert_instance_of EconomicProfile, economic_profile
  end

  def test_it_adds_data
    skip
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
  end

  def test_median_household_income_in_year
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
    expected_1 = 50000
    expected_2 = 55000

    assert_equal expected_1, economic_profile.median_household_income_in_year(2005)
    assert_equal expected_2, economic_profile.median_household_income_in_year(2009)
  end

  def test_median_household_income_can_calulcate_average
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
    expected = 55000
    assert_equal expected, economic_profile.median_household_income_average
  end

  def test_children_in_poverty_in_year
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
    assert_in_delta 0.184, economic_profile.children_in_poverty_in_year(2012), 0.005
  end

  def test_free_or_reduced_price_lunch_returns_percentage_and_number_for_year
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
    assert_in_delta 0.023, economic_profile.free_or_reduced_price_lunch_percentage_in_year(2014), 0.005
    assert_equal 100, economic_profile.free_or_reduced_price_lunch_number_in_year(2014)
  end

  def test_title_i_returns_data_from_year
    data = data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
      }

    economic_profile = EconomicProfile.new(data)
    assert_in_delta 0.543, economic_profile.title_i_in_year(2015), 0.005
  end

end
