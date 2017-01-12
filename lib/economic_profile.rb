require_relative 'data_translator'

class EconomicProfile
  include DataTranslator
  attr_accessor :name,
                :median_household_income,
                :children_in_poverty,
                :title_i,
                :free_or_reduced_price_lunch

  def initialize(data)
    @name = upcase_name(data[:name])
    @median_household_income = data[:median_household_income]
    @children_in_poverty     = data[:children_in_poverty]
    @free_or_reduced_price_lunch = data[:free_or_reduced_price_lunch]
    @title_i = data[:title_i]
  end

  def add_new_data(row_data)
    row_data.each_key do |key|
      if key ==  :median_household_income
        store_income_data(key, row_data[key])
      elsif key == :children_in_poverty
        store_poverty_data(key, row_data[key])
      elsif key == :title_i
        store_title_i_data(key, row_data[key])
      elsif key == :free_or_reduced_price_lunch
        store_lunch_data(key, row_data[key])
      end
    end
  end

  def store_income_data(key, data)
    if median_household_income == nil
      @median_household_income = data
    else
      @median_household_income.merge!(data) do |years, original, addition|
        original.merge(addition)
    end
  end
  end

  def store_poverty_data(key, data)
    if children_in_poverty == nil
      @children_in_poverty = data
    else
      @children_in_poverty.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_title_i_data(key, data)
    if title_i == nil
      @title_i = data
    else
      @title_i.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

  def store_lunch_data(key, data)
    if free_or_reduced_price_lunch == nil
      @free_or_reduced_price_lunch = data
    else
      free_or_reduced_price_lunch.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

end
