require_relative "district_repository"

class HeadcountAnalyst
  attr_reader :district_repository
  def initialize(district_repository)
    @district_repository = district_repository.districts
  end

  def kindergarten_participation_rate_variation(first_district, second_district)
    # first_district average / second_district average
    # calculate_enrollment_average(first_district) / calculate_enrollment_average(second_district)
    #use fetch(:against) to get 2nd district name

    first_district = district_repository.fetch(first_district)
    second_district = district_repository.fetch(second_district.fetch(:against))

    rate = calculate_enrollment_average(first_district) / calculate_enrollment_average(second_district)
    rate.round(3)

  end

  def calculate_enrollment_average(district)
    rates = district.enrollment.kindergarten.values
    rates.map! do |rate|
      rate.to_f
    end
    sum = rates.reduce(:+).round(3)
    average = sum / rates.count
    average.round(3)
    # sum of all the enrollment rates / # of yrs we have data for
  end

  def kindergarten_participation_rate_variation_trend(fist_district, second_district)
    # comparing district enrollment to state average by year
    # district_one.merge(state_data)
    # do |year, district_data, state_data|
    # district_data/state_data

    

  end

end
