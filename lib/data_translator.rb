require 'csv'
require "pry"
module DataTranslator

    def load_csv(file)
      CSV.open "#{file}",
          headers:true,
          header_converters: :symbol
    end

    def upcase_name(name)
      name.upcase.strip
    end

    def format_number(number)
      # number.to_s[0..4].to_f
      (number.to_f * 1000).floor / 1000.0
    end
end
