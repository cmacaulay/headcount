require_relative 'data_translator'

class EconomicProfile
  include DataTranslator
  attr_accessor :name,
                :median_household_income,
                :children_in_poverty,
                :title_i

  def initialize(data)
    @name = upcase_name(data[:name])
    @median_household_income = data[:median_household_income]
    @children_in_poverty     = data[:children_in_poverty]
    # @free_or_reduced_price_lunch
    @title_i = data[:title_i]
  end

  def add_new_data(row_data)
    if row_data.has_key?(:median_household_income)
    data = row_data[:median_household_income]
      median_household_income.merge!(data) do |years, original, addition|
        original.merge(addition)
      end
    elsif children_in_poverty == nil
      @children_in_poverty = row_data[:children_in_poverty]
    elsif row_data.has_key?(:children_in_poverty)
      data = row_data[:children_in_poverty]
      children_in_poverty.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    elsif title_i == nil
      @title_i = row_data[:title_i]
    elsif row_data.has_key?(:title_i)
      data = row_data[:title_i]
      title_i.merge!(data) do |year, original, addition|
        original.merge(addition)
      end
    end
  end

end
