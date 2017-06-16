require 'yomu'
class ReadFile
  def rtf(file_name)
    p file_name
    votes = []
    yomu = Yomu.new file_name
    page = yomu.text

     vote = {}
     vote[:datetime] = page[/від.+\d{2}\.\d{2}\.\d{4}/].gsub(/від/,'').strip

     vote[:res] = page[/РІШЕННЯ.+/].strip

     paragraf =  page.gsub(/\n/, '\n')

     vote[:name] = paragraf[/місто Миколаїв.+Рішення ухвалює/].gsub(/(місто Миколаїв|від.+\d{2}\.\d{2}\.\d{4}|Рішення ухвалює|\\n|"|«|»|)/,'').gsub(/(\s{2,}|@�������ППр<џ�Ж…insrsid5901197)/,' ').strip
     p vote[:name]
     vote[:voteds] = []

     paragraf[/По-батькові.+(УСЬОГО:|ВСЬОГО:)/].gsub(/\s{2,}/, ' ').gsub(/(По-батькові|Вибір|УСЬОГО:|ВСЬОГО:)/,'').split(/\\n/).each do |v|

       next if v.strip.size==0
       voted = v.strip
       if voted[/\d+/]
         vote[:voteds] << []
       else
         vote[:voteds].last << voted
       end
     end
    votes << vote
    return votes
  end
end
