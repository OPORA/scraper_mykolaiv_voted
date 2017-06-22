require 'yomu'
class ReadFile
  def rtf(file_name)
    p file_name
    votes = []
    yomu = Yomu.new file_name
    page = yomu.text
     vote = {}

     page.split(/\n/).each do |p|
       paragraf = p.strip
       next if paragraf == ""
       next if paragraf[/^[[:blank:]]$/]
       next if paragraf == "УКРАЇНА"
       next if paragraf == "Миколаївська міська РАДА"
       next if paragraf[/ ГОЛОСУВАННЯ/]
       next if paragraf[/сесія Миколаївської міської ради VII скликання/]
       next if paragraf == "місто Миколаїв"
       next if paragraf == "������\u007F��Ђ†aautoмісто Миколаїв"
       next if paragraf[/Рішення ухвалює/]
       next if paragraf[/УСЬОГО:/]
       next if paragraf[/УСЬОГО ПРОГОЛОСУВАЛО:/]
       next if paragraf[/З НИХ:/]
       next if paragraf[/"ЗА":/]
       next if paragraf[/"ПРОТИ":/]
       next if paragraf[/"УТРИМАЛОСЬ":/]
       next if paragraf[/"НЕ ГОЛОСУВАЛО":/]
       next if paragraf[/Посада.+Призвіще/]
       next if paragraf == "Вибір"
       next if paragraf == "Прізвище, Ім'я, По-батькові"
       p paragraf
       if vote.empty?
       vote[:datetime] = paragraf[/від.+\d{2}\.\d{2}\.\d{4}/].gsub(/від/,'').strip
       elsif paragraf == "№ п/п"
          vote[:voteds] = []
       elsif vote[:voteds].nil?
          if vote[:name].nil?
            vote[:name] = paragraf.gsub(/@�������ППр<џ�Ж…insrsid5901197/,'')
          else
            vote[:name] = vote[:name] + " " + paragraf
          end
       elsif paragraf[/РІШЕННЯ.+/]
       vote[:res] = paragraf[/РІШЕННЯ.+/]
       else
         if paragraf[/^\d+$/]
           vote[:voteds] << []
         else
           vote[:voteds].last << paragraf
         end
       end
     end
    votes << vote
    return votes
  end
end
