require_relative 'test_helper'
require './lib/result_set'

class ResultSetTest < Minitest::Test

  def test_it_exists
    rs = ResultSet.new

    assert_instance_of ResultSet, rs
    assert_equal ResultSet, rs.class
  end

  def test_mathching_districts_is_an_array
    rs = ResultSet.new

    assert_equal Array, rs.matching_districts.class
  end

  def test_can_assign_matching_districts
    skip
    rs = ResultSet.new({matching_districts: "test"})

    assert_equal "test", rs.matching_districts
  end

  def test_can_assign_statewide_average
    skip
    rs = ResultSet.new({statewide_average: "test"})

    assert_equal "test", rs.statewide_average
  end

  # def test_matching_districts_returns_free_reduced_lunch
  #   r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5})
  #   rs = ResultSet.new(matching_districts: [r1])
  #
  #   assert_equal 0.5, rs.matching_districts.first.free_and_reduced_price_lunch_rate
  # end
  #
  # def test_matching_districts_returns_children_in_poverty_rate
  #   r1 = ResultEntry.new({children_in_poverty_rate: 0.25})
  #   rs = ResultSet.new(matching_districts: [r1])
  #
  #   assert_equal 0.25, rs.matching_districts.first.children_in_poverty_rate
  # end
  #
  # def test_matching_districts_returns_high_school_graduation_rate
  #   r1 = ResultEntry.new({high_school_graduation_rate: 0.75})
  #   rs = ResultSet.new(matching_districts: [r1])
  #
  #   assert_equal 0.75, rs.matching_districts.first.high_school_graduation_rate
  # end
  #
  # def test_statewide_average_returns_free_reduce_lunch_rate
  #   r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3})
  #   rs = ResultSet.new(statewide_average: r1)
  #
  #   assert_equal 0.3, rs.statewide_average.free_and_reduced_price_lunch_rate
  # end
  #
  # def test_statewide_average_returns_children_in_poverty_rate
  #   r1 = ResultEntry.new({children_in_poverty_rate: 0.2})
  #   rs = ResultSet.new(statewide_average: r1)
  #
  #   assert_equal 0.2, rs.statewide_average.children_in_poverty_rate
  # end
  #
  # def test_statewide_average_returns_high_school_graduation_rate
  #   r1 = ResultEntry.new({high_school_graduation_rate: 0.6})
  #   rs = ResultSet.new(statewide_average: r1)
  #
  #   assert_equal 0.6, rs.statewide_average.high_school_graduation_rate
  # end
  #
  # def test_can_return_matching_district_statewide_average_free_reduced_lunch_rate
  #   r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5})
  #   r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3})
  #   rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)
  #
  #   assert rs.matching_districts.first.free_and_reduced_price_lunch_rate == 0.5 &&
  #   rs.statewide_average.free_and_reduced_price_lunch_rate == 0.3
  # end
  #
  # def test_can_return_matching_district_statewide_average_children_in_poverty_rate
  #   r1 = ResultEntry.new({children_in_poverty_rate: 0.25})
  #   r2 = ResultEntry.new({children_in_poverty_rate: 0.2})
  #   rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)
  #
  #   assert rs.matching_districts.first.children_in_poverty_rate == 0.25 &&
  #   rs.statewide_average.children_in_poverty_rate == 0.2
  # end
  #
  # def test_can_return_matching_district_statewide_high_school_graduation_rate
  #   r1 = ResultEntry.new({high_school_graduation_rate: 0.75})
  #   r2 = ResultEntry.new({high_school_graduation_rate: 0.6})
  #   rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)
  #
  #   assert rs.matching_districts.first.high_school_graduation_rate == 0.75 &&
  #   rs.statewide_average.high_school_graduation_rate == 0.6
  # end
  #
  # def test_can_return_matching_district_statewide_all
  #   r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
  #                         children_in_poverty_rate: 0.25,
  #                         high_school_graduation_rate: 0.75})
  #   r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3,
  #                         children_in_poverty_rate: 0.2,
  #                         high_school_graduation_rate: 0.6})
  #   rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)
  #
  #   assert rs.matching_districts.first.high_school_graduation_rate == 0.75 &&
  #   rs.statewide_average.high_school_graduation_rate == 0.6
  #
  #   assert rs.matching_districts.first.children_in_poverty_rate == 0.25 &&
  #   rs.statewide_average.children_in_poverty_rate == 0.2
  #
  #   assert rs.matching_districts.first.free_and_reduced_price_lunch_rate == 0.5 &&
  #   rs.statewide_average.free_and_reduced_price_lunch_rate == 0.3
  # end
  #
  # def test_returns_nil_if_keys_are_missing
  #   r1 = ResultEntry.new({test: 0.25})
  #   rs = ResultSet.new(matching_districts: [r1])
  #
  #   assert rs.matching_districts.first.children_in_poverty_rate.nil?
  # end


end
