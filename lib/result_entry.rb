class ResultEntry
  attr_reader   :free_and_reduced_price_lunch_rate,
                :children_in_poverty_rate,
                :high_school_graduation_rate,
                :median_household_income

  def initialize(data)
    @free_and_reduced_price_lunch_rate =
    data[:free_and_reduced_price_lunch_rate]
    @children_in_poverty_rate          = data[:children_in_poverty_rate]
    @high_school_graduation_rate       = data[:high_school_graduation_rate]
    @median_household_income           = data[:median_household_income]
  end

end
