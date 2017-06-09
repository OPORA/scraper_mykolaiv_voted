require_relative 'get_page'
require_relative 'scrape_all_votes'
require_relative 'get_mps'


class GetPages
  def initialize
    @all_page = []
    $all_mp = GetMp.new
    url = "http://www.lutskrada.gov.ua/sesiyi-miskoyi-radi"
    page = GetPage.page(url)
    check = nil
    page.css('.even p').each do |p|
      if p.text == "Міська рада 7-го скликання"
        check = 1
      end
      next if check.nil?
      next if p.text == "Міська рада 7-го скликання"
      next if p.text == ""
      @all_page << { cadent: p.text[/\(.+\)/].gsub(/(\(|\))/,''), url: p.css('a')[0][:href] }
    end
  end
  def get_all_votes
    @all_page.each do |p|
      p p[:cadent]
      GetAllVotes.votes(p[:url], p[:cadent])
    end
  end
end
