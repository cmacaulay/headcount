require 'csv'

module DataTranslator

    def upcase_name(name)
      name.upcase.strip
    end

    def format_number(number)
      if number.class == String
        number = 0
      else
        (number * 1000).floor / 1000.0
      end
    end


end
