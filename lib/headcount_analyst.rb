require_relative "district_repository"

class HeadcountAnalyst

  def initialize(district_repository)
    @district_repository = district_repository
    binding.pry
  end

  def kindergarten_participation_rate_variation(fist_district, second_district)

    # first_district average / second_district average
    # calculate_enrollment_average(first_district) / calculate_enrollment_average(second_district)
    #use fetch(:against) to get 2nd district name
  end

  def calculate_enrollment_average(district)

    # sum of all the enrollment rates / # of yrs we have data for

  end

  def kindergarten_participation_rate_variation_trend(fist_district, second_district)
    # comparing district enrollment to state average by year
    # district_one.merge(state_data)
    # do |year, district_data, state_data|
    # district_data/state_data

  end

end
