require 'yomu'
class ReadFile
  def rtf(file_name)
    p file_name
    votes = []
    yomu = Yomu.new file_name
    page = yomu.text

     vote = {}
     vote[:datetime] = page[/^від.+/].gsub(/від/,'').strip
     unless page[/ГОЛОСУВАННЯ НЕ ПРОВОДИЛОСЬ/]
       vote[:res] = page[/РІШЕННЯ.+/].strip
     else
       vote[:res] = "ГОЛОСУВАННЯ НЕ ПРОВОДИЛОСЬ"
     end

     vote[:name] = page.split(/\n/).find{|str| str.strip[/^\d+\.\s/]}.strip.gsub(/^\d+\.\s/,'').strip
     # vote[:number] = page.split(/\n/).find{|str| str.strip[/^\d+\.\s/]}.strip[/^\d+/]
     vote[:voteds] = []
     paragraf =  page.gsub(/\n/, '\n')
     paragraf[/Вибір.+(УСЬОГО:|ВСЬОГО:)/].gsub(/\s{2,}/, ' ').gsub(/(Вибір|УСЬОГО:|ВСЬОГО:)/,'').split(/\\n/).each do |v|
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
