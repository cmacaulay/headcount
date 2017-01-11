require_relative 'test_helper'
require './lib/statewide_test'

class StatewideTestTest < Minitest::Test

  def test_it_stores_name
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    st = StatewideTest.new(row_1)

    expected = "ACADEMY 20"
    assert_equal expected, st.name
  end

  def test_it_stores_data_when_create
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    st = StatewideTest.new(row_1)

    expected = {2008 => {"Math" => 0.64}}
    assert_equal expected, st.third_grade
  end

  def test_it_stores_data_when_create
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Reading" => 0.4}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)

    expected = {2008 => {"Math" => 0.64, "Reading" => 0.4}}
    assert_equal expected, st.third_grade
  end

  def test_it_stores_data_when_create_with_new_year
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Reading" => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :third_grade => {2009 => {"Math" => 0.09}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)

    expected = {2008 => {"Math" => 0.64, "Reading" => 0.4}, 2009 => {"Math" => 0.09}}
    assert_equal expected, st.third_grade
  end

end





# Location,Score,TimeFrame,DataFormat,Data
# Colorado,Writing,2014,Percent,0.56183
# ACADEMY 20,Math,2008,Percent,0.64
# ACADEMY 20,Math,2010,Percent,0.672
# ACADEMY 20,Reading,2008,Percent,0.843
# ACADEMY 20,Writing,2008,Percent,0.734
# ACADEMY 20,Writing,2009,Percent,0.701
# ADAMS COUNTY 14,Math,2008,Percent,0.22
# ADAMS COUNTY 14,Math,2009,Percent,0.3


# district => grade => year => subject => score

# statewide_test.proficient_by_grade(3)
# => { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
#      2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
#      2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
#      2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
#      2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
#      2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
#      2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
#    }
