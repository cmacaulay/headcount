require_relative 'test_helper'
require './lib/statewide_test'
require './lib/statewide_test_repository'

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

  def test_it_adds_all_of_the_data
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    row_11 = { :name => "ACADEMY 20", :third_grade => {2009 => {"Writing" => 0.77}}}
    row_2 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {"Reading" => 0.4}}}
    row_22 = { :name => "ACADEMY 20", :eighth_grade => {2010 => {"Math" => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :math => {2009 => {"Black" => 0.99}}}
    row_33 = { :name => "ACADEMY 20", :math => {2011 => {"Asian" => 0.77}}}
    row_4 = { :name => "ACADEMY 20", :reading => {2009 => {"White" => 0.60}}}
    row_44 = { :name => "ACADEMY 20", :reading => {2015 => {"Black" => 0.50}}}
    row_5 = { :name => "ACADEMY 20", :writing => {2009 => {"Native American" => 0.59}}}
    row_55 = { :name => "ACADEMY 20", :writing => {2010 => {"Hispanic" => 0.19}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)
    st.add_new_data(row_4)
    st.add_new_data(row_5)
    st.add_new_data(row_11)
    st.add_new_data(row_22)
    st.add_new_data(row_33)
    st.add_new_data(row_44)
    st.add_new_data(row_55)

    third_grade  = {2008=>{"Math"=>0.64}, 2009=>{"Writing"=>0.77}}
    eighth_grade = {2008=>{"Reading"=>0.4}, 2010=>{"Math"=>0.4}}
    math         = {2009=>{"Black"=>0.99}, 2011=>{"Asian"=>0.77}}
    reading      = {2009=>{"White"=>0.60}, 2015=>{"Black"=>0.50}}
    writing      = {2009=>{"Native American"=>0.59}, 2010=>{"Hispanic"=>0.19}}

    assert_equal third_grade, st.third_grade
    assert_equal eighth_grade, st.eighth_grade
    assert_equal math, st.math
    assert_equal reading, st.reading
    assert_equal writing, st.writing
  end

  def test_proficient_by_grade
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    row_2 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Reading" => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :third_grade => {2009 => {"Math" => 0.09}}}

    row_4 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {"Math" => 0.88}}}
    row_5 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {"Reading" => 0.53}}}
    row_6 = { :name => "ACADEMY 20", :eighth_grade => {2009 => {"Math" => 0.76}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)
    st.add_new_data(row_4)
    st.add_new_data(row_5)
    st.add_new_data(row_6)

    third_grade = {2008=>{"Math"=>0.64, "Reading"=>0.4}, 2009=>{"Math"=>0.09}}
    eighth_grade = {2008=>{"Math"=>0.88, "Reading"=>0.53}, 2009=>{"Math"=>0.76}}
    assert_equal third_grade, st.proficient_by_grade(3)
    assert_equal eighth_grade, st.proficient_by_grade(8)
    assert_raises(UnknownDataError), st.proficient_by_grade(99)
  end

  def test_proficient_by_race_or_ethnicity
    row_1 = { :name => "ACADEMY 20", :third_grade => {2008 => {"Math" => 0.64}}}
    row_11 = { :name => "ACADEMY 20", :third_grade => {2009 => {"Writing" => 0.77}}}
    row_2 = { :name => "ACADEMY 20", :eighth_grade => {2008 => {"Reading" => 0.4}}}
    row_22 = { :name => "ACADEMY 20", :eighth_grade => {2010 => {"Math" => 0.4}}}
    row_3 = { :name => "ACADEMY 20", :math => {2009 => {"Black" => 0.99}}}
    row_33 = { :name => "ACADEMY 20", :math => {2011 => {"Asian" => 0.77}}}
    row_4 = { :name => "ACADEMY 20", :reading => {2009 => {"White" => 0.60}}}
    row_44 = { :name => "ACADEMY 20", :reading => {2015 => {"Black" => 0.50}}}
    row_5 = { :name => "ACADEMY 20", :writing => {2009 => {"Native American" => 0.59}}}
    row_55 = { :name => "ACADEMY 20", :writing => {2010 => {"Hispanic" => 0.19}}}

    st = StatewideTest.new(row_1)
    st.add_new_data(row_2)
    st.add_new_data(row_3)
    st.add_new_data(row_4)
    st.add_new_data(row_5)
    st.add_new_data(row_11)
    st.add_new_data(row_22)
    st.add_new_data(row_33)
    st.add_new_data(row_44)
    st.add_new_data(row_55)

    third_grade  = {2008=>{"Math"=>0.64}, 2009=>{"Writing"=>0.77}}
    eighth_grade = {2008=>{"Reading"=>0.4}, 2010=>{"Math"=>0.4}}
    math         = {2009=>{"Black"=>0.99}, 2011=>{"Asian"=>0.77}}
    reading      = {2009=>{"White"=>0.60}, 2015=>{"Black"=>0.50}}
    writing      = {2009=>{"Native American"=>0.59}, 2010=>{"Hispanic"=>0.19}}

    assert_equal third_grade, st.third_grade
    assert_equal eighth_grade, st.eighth_grade
    assert_equal math, st.math
    assert_equal reading, st.reading
    assert_equal writing, st.writing

    st.proficient_by_race_or_ethnicity(:asian)
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
