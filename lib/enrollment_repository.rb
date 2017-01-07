require 'csv'
require_relative 'enrollment'

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = Hash.new
  end

  def load_data(data_files)
    create_repository(files(data_files))
  end

  def files(data_files)
    data_files[:enrollment]
  end

  def create_repository(files)
    kindergarten_data(files).each_key do |district_name|
      if files.has_key?(:high_school_graduation)
        enrollments[district_name] = Enrollment.new( {
                      :name => district_name,
                      :kindergarten => (kindergarten_data(files))[district_name],
                      :high_school_graduation => (graduation_rates(files))[district_name]
                      } )
      else
        enrollments[district_name] = Enrollment.new( {
                      :name => district_name,
                      :kindergarten => (kindergarten_data(files))[district_name]
                      } )
      end
    end
  end

  def kindergarten_data(files)
    store_data(files, :kindergarten)
  end

  def graduation_rates(files)
    store_data(files, :high_school_graduation)
  end

  def store_data(files, key)
    if files.has_key?(key)
      save_contents(load_csv(files[key]))
    end
  end

  def load_csv(file)
    CSV.open "#{file}",
        headers:true,
        header_converters: :symbol
  end

  def save_contents(contents)
    data = {}
    contents.each do |row|
      data = enrollment_rates(data, row)
    end
    data
  end

  def enrollment_rates(data, row)
    data = initialize_new_key(district_name(row), data)
    data.fetch(district_name(row))[year(row)] = rate(row)
    data
  end

  def district_name(row)
    row[:location].upcase
  end

  def year(row)
    row[:timeframe]
  end

  def rate(row)
    row[:data]
  end

  def initialize_new_key(key, data)
    if !data.has_key?(key)
        data[key] = {}
    end
    data
  end

  def find_by_name(name)
     enrollments[name.upcase]
   end
  end
