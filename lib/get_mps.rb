require 'open-uri'
require 'json'
class GetMp
  def initialize
    @data_hash = JSON.load(open('https://scraperlutskdeputy.herokuapp.com/'))
  end
  def serch_mp(full_name)
     p full_name
   if full_name == "Рабан МикитаТарасович"
     name = "Рабан Микита Тарасович"
   else
     name =full_name.gsub(/'/,'’').gsub(/ Депутатські повноваження складено/,'')
   end
   if full_name == "Романюк Микола Ярославович"
     return 1112
   else
     data = @data_hash.find {|k| k["full_name"] == name  }
     return data["deputy_id"]
   end
  end
end
