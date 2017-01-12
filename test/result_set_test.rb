require_relative 'test_helper'
require './lib/result_set'

class ResultSetTest < Minitest::Test

  def test_can_assign_matching_districts
    rs = ResultSet.new({matching_districts: "This is a test."})

    assert_equal "This is a test.", rs.matching_districts
  end

  def test_can_assign_statewide_average
    rs = ResultSet.new({statewide_average: "This is a test."})

    assert_equal "This is a test.", rs.statewide_average
  end

  def test_matching_districts_returns_free_reduced_lunch
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5})

    rs = ResultSet.new(matching_districts: [r1])

    assert_equal 0.5, rs.matching_districts.first.free_and_reduced_price_lunch_rate
  end

  def test_matching_districts_returns_children_in_poverty_rate
    r1 = ResultEntry.new({children_in_poverty_rate: 0.25})

    rs = ResultSet.new(matching_districts: [r1])

    assert_equal 0.25, rs.matching_districts.first.children_in_poverty_rate
  end
  #
  def test_matching_districts_returns_high_school_graduation_rate
    r1 = ResultEntry.new({high_school_graduation_rate: 0.75})

    rs = ResultSet.new(matching_districts: [r1])

    assert_equal 0.75, rs.matching_districts.first.high_school_graduation_rate
  end

  def test_statewide_average_returns_free_reduce_lunch_rate
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3})

    rs = ResultSet.new(statewide_average: r1)

    assert_equal 0.3, rs.statewide_average.free_and_reduced_price_lunch_rate
  end

  def test_can_manage_two_result_entries
    r1 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.5,
	                        children_in_poverty_rate: 0.25,
                          high_school_graduation_rate: 0.75})
    r2 = ResultEntry.new({free_and_reduced_price_lunch_rate: 0.3,
	                        children_in_poverty_rate: 0.2,
                          high_school_graduation_rate: 0.6})

    rs = ResultSet.new(matching_districts: [r1], statewide_average: r2)

    assert_equal 0.5, rs.matching_districts.first.free_and_reduced_price_lunch_rate
    assert_equal 0.25, rs.matching_districts.first.children_in_poverty_rate
    assert_equal 0.75, rs.matching_districts.first.high_school_graduation_rate
    assert_equal 0.3, rs.statewide_average.free_and_reduced_price_lunch_rate
    assert_equal 0.2, rs.statewide_average.children_in_poverty_rate
    assert_equal 0.6, rs.statewide_average.high_school_graduation_rate
  end


end
