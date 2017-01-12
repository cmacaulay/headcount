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
      number.to_s[0..4].to_f
    end

    def format_ethnicity(race)
      if race == "Hawaiian/Pacific Islander"
        race.split("/").last.gsub(/( )/, '_').downcase!.to_sym
      else
        race.gsub(/( )/, '_').downcase!.to_sym
      end
    end
end
