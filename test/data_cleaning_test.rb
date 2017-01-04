require './test/test_helper'

class DataCleaningTest < Minitest::Test

  def test_string_should_be_upcase
    dct = DataCleaning.new

    assert_equal "COLORADO", dct.upcase_string("Colorado")
    assert_equal "COLORADO", dct.upcase_string("CoLoRaDo")
    assert_equal "COLORADO", dct.upcase_string("colorado")
    assert_equal "COLORADO", dct.upcase_string("colOrado  ")
  end

  def test_number
    dct = DataCleaning.new

    assert_equal "COLORADO", dct.format_number("N/A")
    assert_equal "COLORADO", dct.upcase_string(0.0)
    assert_equal "COLORADO", dct.upcase_string("colorado")
    assert_equal "COLORADO", dct.upcase_string("colOrado  ")
  end


end
