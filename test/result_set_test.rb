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
end
