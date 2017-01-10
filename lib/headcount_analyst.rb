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
    graduation_variation = calculate_graduation_variation(district)
    variance = kindergarten_variation / graduation_variation
    format_number(variance)
    # graduation_variation   = graduation_rate / statewide_averate
# kindergarten_variation / graduation_variation
    #ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20') # =>

  end

  def calculate_kindergarten_variation(district)
    state  = district_repository.fetch("COLORADO")
    calculate_enrollment_average(district) / calculate_enrollment_average(state)
  end

  def calculate_graduation_variation(district)
    state = district_repository.fetch("COLORADO")
    calculate_hs_enrollment_average(district) / calculate_hs_enrollment_average(state)
  end

  def calculate_hs_enrollment_average(district)
    if district.enrollment.high_school_graduation.nil?
      rates = []
    else
      rates = district.enrollment.high_school_graduation.values
    end
    rates.map! do |rate|
      rate.to_f
      end
    sum = format_number(rates.reduce(:+))
    average = sum / rates.count
    format_number(average)
      # sum of all the enrollment rates / # of yrs we have data for
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district)
    if for_district[:for] != "STATEWIDE"
      district_correlation(for_district)
    elsif for_district[:for] == "STATEWIDE"
      statewide_correlation
    else for_district[:across]
      multi_district_correlation(for_district)
    end

    #   for_district[:for] == "STATEWIDE" ? statewide_correlation : district_correlation(for_district)
    # if for_district[:for] == "STATEWIDE"
    #   for_district[:for] = "COLORADO"
    #   correlation = kindergarten_participation_against_high_school_graduation(for_district[:for])
    #   correlation > 0.7 ? true : false
    #   # binding.pry
    # else
      # correlation = kindergarten_participation_against_high_school_graduation(for_district[:for])
      # 1.5 > correlation && correlation > 0.6 ? true : false
      # # end
  end

  def district_correlation(for_district)
    correlation = kindergarten_participation_against_high_school_graduation(for_district[:for])
    1.5 > correlation && correlation > 0.6 ? true : false
#working
  end

  def statewide_correlation
    correlation = district_repository.map do |key, value|
      # next key if key == "COLORADO"
      kindergarten_participation_against_high_school_graduation(key)
    end
    statewide_correlation = (correlation.reduce(:+)) / (correlation.count)
    statewide_correlation > 0.7 ? true : false    # district_correlations.count(true).to_f / district_correlations.count > 0.70
  end

  def multi_district_correlation(for_district)
    binding.pry
    # correlation = for_district[across:]
    # kindergarten_participation_against_high_school_graduation(for_district[across:])
  end

end
