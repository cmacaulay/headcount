require_relative 'result_entry'

#this object aggregates and provides an interface
#/ access to the given results
class ResultSet

  def matching_districts
    []
    #returns an array of result entry objects
    # what is matching?
  end

  def statewide_average
    #returns a single ResultEntry object
    #that represents the average accross the state
    # most likely for the different economic indicators
    # :free_and_reduced_price_lunch_rate
    # :children_in_poverty_rate
    # :high_school_graduation_rate
    # :median_household_income
  end

end
