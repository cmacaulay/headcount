require_relative "district_repository"

class HeadcountAnalyst
  attr_reader :district_repository
  def initialize(district_repository)
    @district_repository = district_repository.districts
  end

  def kindergarten_participation_rate_variation(first_district, against_district)
    # first_district average / against_district average
    # calculate_enrollment_average(first_district) / calculate_enrollment_average(against_district)
    #use fetch(:against) to get 2nd district name

    first_district = district_repository.fetch(first_district)
    against_district = district_repository.fetch(against_district.fetch(:against))

    rate = calculate_enrollment_average(first_district) / calculate_enrollment_average(against_district)
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

  def kindergarten_participation_rate_variation_trend(first_district, state_data)
    # comparing district enrollment to state average by year
    # district_one.merge(state_data)
    # do |year, district_data, state_data|
    # district_data/state_data
    first_district = access_data( district_repository.fetch( first_district ) )
    state_data = access_data( district_repository.fetch(state_data.fetch( :against ) ) )

    first_district.merge(state_data) do |year, district_rate, state_rate|
      district_rate = district_rate.to_f
      state_rate    = state_rate.to_f
      
      comparison = district_rate / state_rate
      comparison.round(3)
    end
  end

  def access_data(enrollment_object)
    enrollment_object.enrollment.kindergarten
  end

end
