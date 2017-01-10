require_relative "district_repository"
require_relative "data_translator"

class HeadcountAnalyst
  include DataTranslator

  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository.districts
  end

  def kindergarten_participation_rate_variation(first_district, against_district)
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
  end

  def kindergarten_participation_rate_variation_trend(first_district, state_data)
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
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district)
    if for_district.has_key?(:for)
      for_district[:for] == "STATEWIDE" ? statewide_correlation : district_correlation(for_district)
    else
      multi_district_correlation(for_district)
    end
  end

  def district_correlation(for_district)
    correlation = kindergarten_participation_against_high_school_graduation(for_district[:for])
    1.5 > correlation && correlation > 0.6 ? true : false
  end

  def statewide_correlation
    correlation = district_repository.reject{|key| key == "COLORADO"}.map do |key, value|
                    kindergarten_participation_against_high_school_graduation(key)
                  end
    correlation_count = correlation.map do |number|
                          1.5 > number && number > 0.6 ? true : false
                        end
    true_count = correlation_count.count do |t|
                  t == true
                end

    true_count > (correlation.count * 0.7) ? true : false
  end

  def multi_district_correlation(across_districts)
    districts = across_districts[:across]
    correlation = districts.map do |district|
                    kindergarten_participation_against_high_school_graduation(district)
                  end
    multi_district_correlation = (correlation.reduce(:+)) / (correlation.count)
    multi_district_correlation > 0.7 ? true : false
  end

end
