require_relative "district_repository"
require_relative "data_translator"

class HeadcountAnalyst
  include DataTranslator

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
    format_number(rate)

  end

  def calculate_enrollment_average(district)
    rates = district.enrollment.kindergarten.values
    rates.map! do |rate|
      rate.to_f
    end
    sum = format_number(rates.reduce(:+))
    average = sum / rates.count
    format_number(average)
    # sum of all the enrollment rates / # of yrs we have data for
  end

  def kindergarten_participation_rate_variation_trend(first_district, state_data)
    # comparing district enrollment to state average by year
    # district_one.merge(state_data)
    # do |year, district_data, state_data|
    # district_data/state_data
    first_district = access_kindergarten_data( district_repository.fetch( first_district ) )
    state_data = access_kindergarten_data( district_repository.fetch(state_data.fetch( :against ) ) )

    first_district.merge(state_data) do |year, district_rate, state_rate|
      district_rate = district_rate.to_f
      state_rate    = state_rate.to_f
      comparison = district_rate / state_rate
      format_number(comparison)
    end
  end

  def access_kindergarten_data(enrollment_object)
    enrollment_object.enrollment.kindergarten
  end

  def kindergarten_participation_against_high_school_graduation(for_district)
    district = district_repository.fetch(for_district)
    kindergarten_variation = calculate_kindergarten_variation(district)
    format_number(kindergarten_variation)
    # graduation_variation   = graduation_rate / statewide_averate

    #ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20') # =>

  end

  def calculate_kindergarten_variation(district)
    state  = district_repository.fetch("COLORADO")
    calculate_enrollment_average(district) / calculate_enrollment_average(state)
    # binding.pry
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district)
    for_district = district_repository.fetch(for_district.fetch(:for))
    # kindergarten_participation_against_high_school_graduation(for_district) > 0.6
    # else
    # return false
    #ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE') # => true

  end

  def kindergarten_participation_correlates_with_high_school_graduation(districts)
    #ha.kindergarten_participation_correlates_with_high_school_graduation(
  #:across => ['district_1', 'district_2', 'district_3', 'district_4']) # => true
  end

end
