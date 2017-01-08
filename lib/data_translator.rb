require 'csv'

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
      check_number(number)
       if number.class == Float
         (number * 1000).floor / 1000.0
       else
         number
       end
    end

    def check_number(number)
      number == "#DIV/0!"|| number == "NA" || number == "N/A" ? number = "N/A" : number = number.to_f
    end

    # need year cleaner for iteration 4-median income
    # def year_cleaner(timeframe)
    # result = timeframe.split('-').map { |year| year.to_i }
    # end

end
