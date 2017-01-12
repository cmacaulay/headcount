class ResultEntry
  attr_reader   :free_and_reduced_price_lunch_rate,
                :children_in_poverty_rate,
                :high_school_graduation_rate,
                :median_household_income

  def initialize(i)
    @free_and_reduced_price_lunch_rate = i[:free_and_reduced_price_lunch_rate]
    @children_in_poverty_rate          = i[:children_in_poverty_rate]
    @high_school_graduation_rate       = i[:high_school_graduation_rate]
    @median_household_income           = i[:median_household_income]
    # @name
  end

end
