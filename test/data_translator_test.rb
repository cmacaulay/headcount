require './test/test_helper'
require './lib/data_translator'

class DataTranslatorTest < Minitest::Test



  def test_string_should_be_upcase
    data = DataTranslator.new

    assert_equal "COLORADO", data.upcase_name("Colorado")
    assert_equal "COLORADO", data.upcase_name("CoLoRaDo")
    assert_equal "COLORADO", data.upcase_name("colorado")
    assert_equal "COLORADO", data.upcase_name("colOrado  ")
  end

  def test_number
    data = DataTranslator.new

    assert_equal 0, data.format_number("N/A")
    assert_equal 0.123, data.format_number(0.12345)
  end


end
