require 'open-uri'
require 'json'
class GetMp
  def initialize
    @data_hash = JSON.load(open('https://scrapermykolaivdeputy.herokuapp.com/'))
  end
  def serch_mp(full_name)
     p full_name
     if full_name=="Горбуров Кирил Євгенович"
       name = "Горбуров Кирило Євгенович"
     elsif full_name=="Концевой  Ігор Олександрович"
       name = "Концевой Ігор Олександрович"
     else
       name =full_name.gsub(/'/,'’')
     end
     data = @data_hash.find {|k| k["full_name"] == name  }
     if data.nil?
       raise name
     else
       if full_name == "Мішкур Станіслав Сергійович"
         return 5037
       elsif full_name == "Концевой Ігор Олександрович"
         return 5026
       # elsif full_name == "Омельчук Олександр Андрійович"
       #   return "Омельчук Олександр Андрійович"
       else
         return data["deputy_id"]
       end
     end
  end
end
