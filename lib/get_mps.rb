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
     else
       name =full_name.gsub(/'/,'’')
     end
     data = @data_hash.find {|k| k["full_name"] == name  }
     if data.nil?
       return name
     else
       if full_name == "Мішкур Станіслав Сергійович"
         return 5037
       else
         return data["deputy_id"]
       end
     end
  end
end
